import jinja2
from jinja2 import Environment

templateLoader = jinja2.FileSystemLoader(searchpath="./")
templateEnv = jinja2.Environment(loader=templateLoader, variable_start_string="#{#", variable_end_string="#}#")
TEMPLATE_FILE = "canary.policy.1.xml"
template = templateEnv.get_template(TEMPLATE_FILE)
outputText = template.render() 

print(outputText)