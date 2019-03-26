import os

path = os.path.dirname(__file__)

from chameleon import PageTemplateLoader
templates = PageTemplateLoader(os.path.join(path, "."))
template = templates['canary.policy.1.xml']
print(template())