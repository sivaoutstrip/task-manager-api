# frozen_string_literal: true

json.id task.id
json.title task.title.titleize
json.description task.description || '--'
json.status task.status.titleize
