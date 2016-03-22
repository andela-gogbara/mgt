require "spec_helper"
require_relative "active_record_spec_helper"
describe "Active Record queries" do
  include ActiveRecordSpecHelper
  after(:each) do
    Todo.destroy_all
  end

  context ".destroy_all" do
    it"deletes all rows in a table" do
      todo = Todo.new
      todo.title = %w(task1 task2 task3).sample
      todo.body =  %w(body1 body2 body3).sample
      todo.status = "pending"
      todo.created_at = Time.now.to_s
      todo.save

      expect(Todo.all.length).to eq 1
    end
  end

  context ".first" do
    it "returns first row" do
      seed 3

      expect(Todo.first.nil?).to be false
    end
  end

  context ".last" do
    it "returns first row" do
      seed 3

      expect(Todo.last.nil?).to be false
    end
  end

  context "#destroy" do
    it "deletes a row in a table" do
      seed 3
      Todo.last.destroy

      expect(Todo.all.length).to be 2
    end
  end

  context "#update" do
    it "updates a row" do
      seed 3
      todo = Todo.first
      todo.title = "new title"
      todo.status = "done"
      todo.body = "new body"
      todo.save

      expect(Todo.first.status).to eq "done"
    end
  end

  context ".find" do
    it "finds a row by id" do
      seed 3
      todo = Todo.last
      id = todo.id

      expect(Todo.find(id).nil?).to be false
    end
  end

  context "#save" do
    it "saves an entry" do
      todo = Todo.new
      todo.title = "newtitle"
      todo.body =  "newbody"
      todo.status = "pending"
      todo.created_at = Time.now.to_s
      todo.save

      expect(Todo.all.length).to be 1
    end
  end

  context ".find_by" do
    it "finds a todo by any param" do
      seed 3
      todo = Todo.last

      expect(Todo.find_by(title: todo.title).nil?).to be false
    end
  end

  context ".destroy" do
    it "deletes a row by id" do
      seed 4

      todo = Todo.last
      Todo.destroy(todo.id)

      expect(Todo.all.length).to eq 4
    end
  end

  context ".all" do
    it "returns all rows in a table" do
      seed 4
      expect(Todo.all.length).to eq 4
    end
  end
end
