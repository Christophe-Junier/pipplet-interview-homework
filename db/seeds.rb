# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# ----------------------------------------
# USER: Users of the application
# ----------------------------------------

## TEST TAKERS

# Using array of name to ease creation of datas
%w[Pascal Clément Véronique Justine Mélina].each do |name|
  User.create(
    name: name,
    email: "#{name}@gmail.com"
  )
end

## EXAMINERS

# Using array of hashes to ease creation and mix of datas
[
  { name: 'Laurent', status: 2, expert_language: 1 },
  { name: 'Charles', status: 1, expert_language: 1 },
  { name: 'Adrien',  status: 0, expert_language: 2 },
  { name: 'Audrey',  status: 1, expert_language: 3 },
  { name: 'Marie',   status: 1, expert_language: 4 },
  { name: 'Pauline', status: 0, expert_language: 5 }
].each do |examiner|
  User.create(
    name: examiner[:name],
    email: "#{examiner[:name]}@gmail.com",
    role: 2,
    status: examiner[:status],
    expert_language: examiner[:expert_language]
  )
end

## ADMINS

# Using array of name to ease creation of datas
%w[Christophe].each do |name|
  User.create(
    name: name,
    email: "#{name}@gmail.com",
    role: 1
  )
end

# ----------------------------------------
# TESTINSTANCE: a test taken by a test_taker user and corrected by an examiner user.
# ----------------------------------------

# Repeating N time to ease creation of datas
# Using array of language to ease creation of datas
3.times do
  (1..5).to_a.each do |language|
    test_instance = TestInstance.new( language: language )
    test_instance.users << User.test_taker.sample(1)
    test_instance.save
  end
end
