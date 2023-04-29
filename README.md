# Guide to Deploy Django on IIS using wfastcgi

1. Open a Powershell terminal in Admin mode

2. Browse to c:\inetweb\wwwroot

3. Delete the IIS start files in the c:\inetweb\wwwroot\ directory

4. Checkout the code from the repo:
```
git clone https://github.com/ryancheley/gcp-django-demo mywebsite
```

5. Open VS Code as Admin

6. Open Folder c:\inetweb\wwwroot\mywebsite

7. Trust the Code if given the prompt

8. Open terminal

9. Create a virtual environment:
```
python -m venv venv
```

10. Activate the virtual environment:
```
.\venv\Scripts\activate
```

11. Install the requirements from the requirements.txt file:
```
pip install -r requirements.txt
```

12. Run `wfastcgi-enable` command:
```
wfastcgi-enable
```

13. Update `web.config` to put in needed values (e.g. server name, path to python executable, and path to the Django application):
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

14. Run `migrate` command:
```
python manage.py migrate
```

15. Run development server:
```
python manage.py runserver
```

16. Verify that the site works by opening a web browser and navigating to `http://localhost:8000/`.

17. Stop the development server

18. Collect static files: 
```
python manage.py collectstatic
```

19. Grant Full Permissions for web directory to IIS AppPool\DefaultAppPool

20. Go to IIS Manager

21. Add Virtual Directory to Static Folder

22. Unlock the configuration manager

23. Move `web.config` to parent directory c:\inetweb\wwwroot\

24. Restart the WebSite

That's it! Your Django application should now be deployed and running on IIS.