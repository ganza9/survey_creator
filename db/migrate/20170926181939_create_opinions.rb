class CreateOpinions < ActiveRecord::Migration[5.1]
  def change
    create_table(:opinions) do |t|
      t.column(:opinion, :string)
      t.column(:question_id, :int)

      t.timestamps()
    end
  end
end
