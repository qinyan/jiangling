require 'spec_helper'

describe User do

  context "validations name" do
    it { should_not accept_values_for(:name, nil)}
    it "should reject duplicate name" do
      User.create!(name: "test name", email: "tak.email@163.com", password:"123456")
      user_with_same_name = User.new(name: "test name", email: "email@163.com", password:"123456")
      user_with_same_name.should_not be_valid
    end
  end

  context "validations email" do
    it { should accept_values_for(:email, "john@example.com", "lambda@gusiev.com") }
    it { should_not accept_values_for(:email, "invalid", nil, "a@b", "john@.com") }
    it "should reject duplicate email" do
      User.create!(name: "test email", email: "email@163.com", password:"123456")
      user_with_same_name = User.new(name: "test email", email: "email@163.com", password:"123456")
      user_with_same_name.should_not be_valid
    end
  end

  context "validations password" do
    it { should_not accept_values_for(:password, nil, "a", "a" * 17) }
  end

end