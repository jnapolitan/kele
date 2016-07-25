module Checkpoints
  def create_submission(id, branch = nil, link = nil, comment = nil)
    @id = id.to_s
    @branch = branch.to_s if branch != nil
    @link = link.to_s if link != nil
    @comment = comment.to_s if comment != nil
    self.class.post("#{@api_url}/checkpoint_submissions", create_submission_options)
  end

  def create_submission_options
    { body: { enrollment_id: 13542,
              checkpoint_id: @id, #Checkpoint Submission ID is 1905
              assignment_branch: @branch,
              assignment_commit_link: @link,
              comment: @comment,
            }.to_json,
      headers: { "Content-Type" => "application/json",
                 "authorization" => @auth_token
               }
    }
  end
end
