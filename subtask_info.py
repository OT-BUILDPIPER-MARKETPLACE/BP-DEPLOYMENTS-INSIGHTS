import os
from jira import JIRA
from dotenv import load_dotenv


server_url = os.getenv('SERVER_URL')
email = os.getenv('EMAIL')
auth_token = os.getenv('AUTH_TOKEN')
issue_key=os.getenv('ISSUE_KEY')

def create_jira_object(server_url,email,auth_token):
    try:
        jiraOptions = {'server': server_url}
        jira_obj = JIRA(options = jiraOptions, 
                basic_auth = (email,
                            auth_token))
        
        return jira_obj
    except Exception as e:
        return False
def get_subtasks_of_issue(server_url, email, token, issue_key):
        jira_obj = create_jira_object(server_url=server_url,email=email,auth_token=token)
        issue = jira_obj.issue(issue_key)        
        subtasks = issue.fields.subtasks
        subtask_list = []
        for subtask in subtasks:
            subtask_details = {
                'feature_ticket_id': subtask.key,
                'description': subtask.fields.summary,             
            }
            subtask_list.append(subtask_details)
        print(subtask_list)   

get_subtasks_of_issue(server_url=server_url,email=email, token=auth_token, issue_key=issue_key)
