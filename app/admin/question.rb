ActiveAdmin.register Question do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :question, :answer, :test_id, :time
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
controller do
  def update
    update! do |format|
      format.html { redirect_to admin_questions_path }
    end
  end
  def create
    create! do |format|
      format.html { redirect_to admin_questions_path }
    end
  end
end

show do |ad|
   attributes_table do
     row :question
     row :answer
     row :test_id
   end
end



form do |f|
  f.semantic_errors
  f.inputs do
    f.input :test_id, :as => :select, :collection => Test.all.map{|t| ["#{t.name}", t.id]}
    f.input :question
    f.input :answer, :as => :select, :collection => Option.all.map{|o| ["#{o.option}", o.option]}
    f.input :time, :input_html => { :value => f.object.persisted? ? f.object.time : Question.set_time(params[:question].try(:[], :test_id)), :disabled => Question.disable_time(params[:question].try(:[], :test_id))}
  end
  f.actions
end

index do
  id_column
  column :question
  column :answer
  column :test_id
  column :options do |question|
    question.options.collect(&:option).join(", ")
  end
  column :option do |question|
    link_to "Add Option",new_admin_option_path(:option => {question_id: question.id})
  end
  actions
end

end
