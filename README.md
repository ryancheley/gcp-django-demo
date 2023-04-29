# Guide to Deploy Django on IIS using wfastcgi

1. Open VS Code as Admin
2. Open Folder c:\inetweb\wwwroot\mywebsite
3. Open terminal
4. Checkout the code from the repo:
```
git clone https://github.com/ryancheley/gcp-django-demo .
```
5. Create a virtual environment:
```
python3.11 -m venv venv
```
6. Activate the virtual environment:
```
.\venv\Scripts\activate
```
7. Install the requirements from the requirements.txt file:
```
pip install -r requirements.txt
```
8. Run `wfastcgi-enable` command:
```
wfastcgi-enable
```
9. Update `web.config` to put in needed values (e.g. server name, path to python executable, and path to the Django application):
```
<configuration>
  <system.webServer>
    <handlers>
      <add name="Python FastCGI" path="*" verb="*" modules="FastCgiModule" scriptProcessor="C:\inetweb\wwwroot\mywebsite\venv\Scripts\python.exe|C:\inetweb\wwwroot\mywebsite\venv\Lib\site-packages\wfastcgi.py" resourceType="Unspecified" requireAccess="Script" />
    </handlers>
    <httpErrors errorMode="Detailed" />
    <directoryBrowse enabled="false" />
    <httpProtocol>
      <customHeaders>
        <add name="X-Powered-By" value="Django/3.2.2" />
      </customHeaders>
    </httpProtocol>
    <staticContent>
      <mimeMap fileExtension=".webmanifest" mimeType="application/manifest+json" />
    </staticContent>
  </system.webServer>
</configuration>
```
10. Run `migrate` command:
```
python manage.py migrate
```
11. Run development server:
```
python manage.py runserver
```
12. Verify that the site works by opening a web browser and navigating to `http://localhost:8000/`.

13. Stop the development server

14. Collect static files: 
```
python manage.py collectstatic
```

15. Go to IIS Manager

16. Unlock Configuration Manager system.webServices/handlers

17. Add Virtual Directory to Static Folder

18. Grant Full Permissions for web directory to IIS AppPool\DefaultAppPool

19. Move `web.config` to parent directory c:\inetweb\wwwroot\

20. Unlock the configuration manager

```shell
%windir%\system32\inetsrv\appcmd.exe unlock config /section:system.webServer
```

21. Delete the IIS start files in the c:\inetweb\wwwroot\ directory

21. Restart the WebSite

That's it! Your Django application should now be deployed and running on IIS.