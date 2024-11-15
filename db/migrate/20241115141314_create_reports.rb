class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :reportable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.string :reason

      t.timestamps
    end
  end
end
