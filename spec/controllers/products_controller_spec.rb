require 'spec_helper'

describe ProductsController do

  describe "Get index" do

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "doesn't matter" do
      @product1 = FactoryGirl.create(:product)
      @product2 = FactoryGirl.create(:product)     
      get :index
      assigns[:products].should == [@product1]
      response.should render_template :index
    end
  end
  
  describe "Get show" do

    before :each do
      @product = FactoryGirl.create(:product)
    end

    it "assigns @product" do
      get :show, :id => @product.id
      assigns[:product].should == @product
    end

    it "render template" do
      get :show, :id => @product.id
      response.should render_template :show
    end
  end

  describe "Get new" do
    it "assigns @product" do
      product = FactoryGirl.build(:product)
      get :new
      assigns[:product].should be_new_record
      assigns[:product].should be_instance_of(Product)
    end

    it "render template" do
      product = FactoryGirl.build(:product)
      get :new
      response.should render_template :new
    end
  end

  describe "Post create" do

    context "when product doesn't have name" do

      it "doesn't create a record" do
        expect{post :create, :product => {:price => '12'}}.to change{Product.count}.by(0)
      end

      it "render template new" do
        post :create, :product => {:price => '12'}
        response.should render_template :new
      end
    end

    context "when product have name" do

      it "create new product record " do
        product = FactoryGirl.build(:product)
        expect{ post :create, :product => FactoryGirl.attributes_for(:product)}.to change{Product.count}.by(1)
      end

      it "redirect_to prodcuts_path" do
        product = FactoryGirl.build(:product)
        post :create, :product => FactoryGirl.attributes_for(:product)
        response.should redirect_to products_path
      end
    end
  end

  describe "Get edit" do
    it "assigns @product" do
      product = FactoryGirl.create(:product)
      get :edit, :id => product.id
      assigns[:product].should == product
    end

    it "render template" do
      product = FactoryGirl.create(:product)
      get :edit, :id => product.id
      response.should render_template :edit
    end
  end

  describe "Put update" do

    context "when product params doesn't have name" do
      it "doesn't update a record" do
        product = FactoryGirl.create(:product)
        put :update , :id => product.id , :product => { :name => nil, :description => "sometext"}
        product.description.should_not == "sometext"
      end

      it "render edit template" do
        product = FactoryGirl.create(:product)
        put :update , :id => product.id , :product => { :name => nil, :description => "sometext"}
        response.should render_template :edit
      end
    end

    context "when product params have name" do
      it "update a record" do
        product = FactoryGirl.create(:product)
        put :update , :id => product.id , :product => { :name => "sometitle", :description => "sometext"}
        product.description.should_not == "sometext"
      end
      it "redirect_to product_path" do
        product = FactoryGirl.create(:product)
        put :update , :id => product.id , :product => { :name => "sometitle", :description => "sometext"}
        response.should redirect_to product_path(product)
      end
    end

  end

  describe "Delete destroy" do
    it "assigns @product" do
      product = FactoryGirl.create(:product)
      delete :destroy, :id => product.id
      assigns[:product].should == product
    end

    it "delete a record" do
      product = FactoryGirl.create(:product)
      expect{delete :destroy, :id => product.id}.to change{ Product.count}.by(-1)
    end

    it "redirect_to products_path" do
      product = FactoryGirl.create(:product)
      delete :destroy, :id => product.id
      expect{response}.to redirect_to(products_path)
    end
  end

end