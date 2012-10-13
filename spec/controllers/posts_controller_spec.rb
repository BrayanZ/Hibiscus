require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe PostsController do

  def mock_post(stubs = {})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end

  def mock_kata(stubs = {})
    @mock_kata ||= mock_model(Kata, stubs).as_null_object
  end
  
  context "Unauthenticated user: " do
    it "should allow access to index" do
      get :index
      response.should be_success
    end

    it "should allow access to show a post" do
      Post.should_receive(:find).and_return(mock_post)
      get :show, :id => mock_post.id
      response.should be_success
    end

    it "should allow access to show a kata" do
      Kata.should_receive(:find).and_return(mock_kata)
      get :show, :type => 'Kata', :id => mock_kata.id
      response.should be_success
    end

    it "should not allow access to make a new post" do
      get :new
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to make a new kata" do
      get :new, :type => 'Kata'
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to create a post" do
      post :create
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to create a kata" do
      post :create, :type => 'Kata'
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
    
    it "should not allow access to edit a post" do
      get :edit, :id => mock_post.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to edit a kata" do
      get :edit, :type => 'Kata', :id => mock_kata.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to update a post" do
      put :update, :id => mock_post.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to update a kata" do
      put :update, :type => 'Kata', :id => mock_kata.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to destroy a post" do
      delete :destroy, :id => mock_post.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end

    it "should not allow access to destroy a kata" do
      delete :destroy, :type => 'Kata', :id => mock_kata.id
      flash[:alert].should == "You need to sign in before continuing."
      response.should redirect_to("/users/sign_in")
    end
  end
  
  context "Authenticated user: " do
    before(:each) do
      login
    end

    describe "GET index" do
      it "assigns all posts with type 'Post' as @posts when type is blank" do
        Post.stub(:where).with(:_type => 'Post') { [mock_post] }
        get :index
        assigns(:posts).should eq([mock_post])
      end

      it "assigns all posts with type 'Kata' as @posts when type is 'Kata'" do
        Kata.stub(:where).with(:_type => 'Kata') { [mock_kata] }
        get :index, {:type => 'Kata' }
        assigns(:posts).should eq([mock_kata])
      end
    end

    describe "GET show" do
      it "assigns the requested post as @post" do
        Post.stub(:find).with("37") { mock_post }
        mock_post.should_receive(:listLikes)
        mock_post.should_receive(:listDislikes)
        get :show, :id => "37"
        assigns(:post).should be(mock_post)
      end

      it "assigns the requested kata as @post" do
        Kata.stub(:find).with("37") { mock_kata }
        mock_kata.should_receive(:listLikes)
        mock_kata.should_receive(:listDislikes)
        get :show, :type => 'Kata', :id => "37"
        assigns(:post).should be(mock_kata)
      end
    end

    describe "GET new" do
      it "assigns a new post as @post" do
        Post.stub(:new) { mock_post }
        get :new
        assigns(:post).should be(mock_post)
      end

      it "assigns a new kata as @post" do
        Kata.stub(:new) { mock_kata }
        get :new, :type => 'Kata'
        assigns(:post).should be(mock_kata)
      end
    end

    describe "GET edit" do
      it "assigns the requested post to edit as @post" do
        Post.stub(:find).with("37") { mock_post }
        get :edit, :id => "37"
        assigns(:post).should be(mock_post)
      end

      it "assigns the requested kata to edit as @post" do
        Kata.stub(:find).with("37") { mock_kata }
        get :edit, :type => 'Kata', :id => "37"
        assigns(:post).should be(mock_kata)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "assigns a newly created post as @post" do
          Post.stub(:new).with({'these' => 'params'}) { mock_post(:save => true) }
          post :create, :post => {'these' => 'params'}
          assigns(:post).should be(mock_post)
        end

        it "redirects to the created post" do
          Post.stub(:new) { mock_post(:save => true) }
          post :create, :post => {}
          response.should redirect_to(post_url(mock_post))
        end

        it "assigns a newly created kata as @post" do
          Kata.stub(:new).with({'these' => 'params'}) { mock_kata(:save => true) }
          post :create, :type => 'Kata', :kata => {'these' => 'params'}
          assigns(:post).should be(mock_kata)
        end

        it "redirects to the created kata" do
          Kata.stub(:new) { mock_kata(:save => true) }
          post :create, :type => 'Kata', :kata => {}
          response.should redirect_to(kata_url(mock_kata))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved post as @post" do
          Post.stub(:new).with({'these' => 'params'}) { mock_post(:save => false) }
          post :create, :post => {'these' => 'params'}
          assigns(:post).should be(mock_post)
        end

        it "re-renders the 'new' template" do
          Post.stub(:new) { mock_post(:save => false) }
          post :create, :post => {}
          response.should render_template("new")
        end

        it "assigns a newly created but unsaved kata as @post" do
          Kata.stub(:new).with({'these' => 'params'}) { mock_kata(:save => false) }
          post :create, :type => 'Kata', :kata => {'these' => 'params'}
          assigns(:post).should be(mock_kata)
        end

        it "re-renders the 'new' kata template" do
          Kata.stub(:new) { mock_kata(:save => false) }
          post :create, :type => 'Kata', :post => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested post" do
          Post.stub(:find).with("37") { mock_post }
          mock_post.should_receive(:save)
          put :update, :id => "37", :post => {'these' => 'params'}
        end

        it "assigns the requested post as @post" do
          Post.stub(:find) { mock_post(:update_attributes => true) }
          put :update, :id => "1", :post => {}
          assigns(:post).should be(mock_post)
        end

        it "redirects to the post" do
          Post.stub(:find) { mock_post(:update_attributes => true) }
          put :update, :id => "1", :post => {}
          response.should redirect_to(post_url(mock_post))
        end

        it "updates the requested kata" do
          Kata.stub(:find).with("37") { mock_kata }
          mock_kata.should_receive(:save)
          put :update, :type => 'Kata', :id => "37", :kata => {'these' => 'params'}
        end

        it "assigns the requested kata as @post" do
          Kata.stub(:find) { mock_kata(:update_attributes => true) }
          put :update, :type => 'Kata', :id => "1", :kata => {}
          assigns(:post).should be(mock_kata)
        end

        it "redirects to the kata" do
          Kata.stub(:find) { mock_kata(:update_attributes => true) }
          put :update, :type => 'Kata', :id => "1", :kata => {}
          response.should redirect_to(kata_url(mock_kata))
        end
      end

      describe "with invalid params" do
        it "assigns the post as @post" do
          Post.stub(:find) { mock_post(:update_attributes => false) }
          put :update, :id => "1", :post => {}
          assigns(:post).should be(mock_post)
        end

        it "re-renders the 'edit' template" do
          Post.stub(:find) { mock_post(:save => false) }
          put :update, :id => "1", :post => {}
          response.should render_template("edit")
        end

        it "assigns the kata as @post" do
          Kata.stub(:find) { mock_kata(:update_attributes => false) }
          put :update, :type => 'Kata', :id => "1", :kata => {}
          assigns(:post).should be(mock_kata)
        end

        it "re-renders the 'edit' kata template" do
          Kata.stub(:find) { mock_kata(:save => false) }
          put :update, :type => 'Kata', :id => "1", :kata => {}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested post" do
        Post.stub(:find).with("37") { mock_post }
        mock_post.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the posts list" do
        Post.stub(:find) { mock_post }
        delete :destroy, :id => "1"
        response.should redirect_to(posts_url)
      end
    end

    describe "Destroy Kata" do
      before(:each) do
        @kata = FactoryGirl.build(:kata)
      end

      it "destroy a requested kata" do
        Kata.stub(:find).with("999") { mock_kata }
        mock_kata.should_receive(:destroy)
        delete :destroy, {:id => "999", :type => 'Kata'}
      end

      it "redirects to the kata list" do
        Kata.stub(:find).with("999") { mock_kata }
        delete :destroy, {:id => "999", :type => 'Kata'}
        response.should redirect_to(katas_url)
      end

    end

  end
end
