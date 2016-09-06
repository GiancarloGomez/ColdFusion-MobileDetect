<cfscript>
	/**
	 * MIT License
	 * ===========
	 *
	 * Permission is hereby granted, free of charge, to any person obtaining
	 * a copy of this software and associated documentation files (the
	 * "Software"), to deal in the Software without restriction, including
	 * without limitation the rights to use, copy, modify, merge, publish,
	 * distribute, sublicense, and/or sell copies of the Software, and to
	 * permit persons to whom the Software is furnished to do so, subject to
	 * the following conditions:
	 *
	 * The above copyright notice and this permission notice shall be included
	 * in all copies or substantial portions of the Software.
	 *
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
	 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	 *
	 * -----------------------------------------------------------------------
	 * The demo is running all the Mobile_Detect's internal methods.
	 * Here you can spot detections errors instantly.
	 * -----------------------------------------------------------------------
	 *
	 * @author      Giancarlo Gomez <giancarlo.gomez@gmail.com>
	 * @license     MIT License https://github.com/GiancarloGomez/ColdFusion-MobileDetect/blob/master/LICENSE.md
	 */

	if (structKeyExists(url,"reload")){
		structDelete(session,"agentCheck");
		location("./session.cfm",false);
	}

	// define session variable
	if (!structKeyExists(session,"agentCheck")){
		MobileDetect = new MobileDetect();
		session.agentCheck = {
			"version" 		: MobileDetect.getVersion(),
			"checkedOn" 	: now(),
			"isMobile" 		: MobileDetect.isMobile(),
			"isTablet" 		: MobileDetect.isTablet(),
			"isIpad" 		: MobileDetect.isIPad(),
			"isAndroid" 	: MobileDetect.isAndroidOS(),
			"isIOS" 		: MobileDetect.isIOS(),
			"isCordova" 	: MobileDetect.match("cordova|Crosswalk"),
			"isMacSafari" 	: MobileDetect.match("Macintosh(.*)Version(.*)Safari"),
			"isPhone" 		: MobileDetect.isMobile() && !MobileDetect.isTablet() ? true : false,
			"newCordova" 	: MobileDetect.match("cordova 2|Crosswalk/17|cordova_in_browser")
		};
	}
	repoUrl 	= "https://github.com/GiancarloGomez/ColdFusion-MobileDetect/";
</cfscript>
<cfoutput>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
		<title>Mobile Detect Local Demo</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		<style>
			body{ font:normal 16px/1.5 -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen", "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue", Arial, sans-serif;}
			dl {margin:0;}
			th small {font-weight: 400;}
		</style>
	</head>
	<body>
		<div class="container">
			<header class="page-header">
				<a href="./demo.cfm" class="pull-right btn btn-success">Demo Example</a>
				<h1>
					<a href="#repoUrl#" target="blank">ColdFusion MobileDetect</a>
					<small>v. #session.agentCheck.version#</small>
				</h1>
			</header>
			<section>
				<div class="alert alert-info text-center">User Agent Checked On : #dateTimeFormat(session.agentCheck.checkedOn,"mm/dd/yyyy hh:nn:ss aa")#</div>
				<p>
					This is an example of how to use this library using the session scope. I do not recommend
					setting the entire object to a Session variable as that could eventually be heavy but instead
					assign the rules you need for your app into a struct in your session scope.
				</p>
				<p>
					A good way to test this is using the web developer tools in the browser of your choice and
					changing your user agent string and refreshing. To reset simply delete your cookies for this specific
					site or click on the reset link below.
				</p>
				<p>
					I personally use something like the following which allows me to check for various things which may control
					delivering of assets or rendering different views in an app.
				</p>

				<script src="https://gist.github.com/GiancarloGomez/1ccb627fb0504b67022aeb1e4d7ab65d.js"></script>

				<p class="text-center">
					<a href="./session.cfm?reload" class="btn btn-warning btn-block">Reload Session Check</a>
				</p>

				<table class="table table-striped">
					<thead>
						<tr>
							<th colspan="2">
								Output of <code>session.agentCheck</code>
							</th>
						</tr>
					</thead>
					<tbody>
						<cfloop collection="#session.agentCheck#" item="key">
							<cfscript>
								check = session.agentCheck[key];
								theClass = isBoolean(check) ? (check ? "text-success" : "text-danger") : "";
								if (isDate(check))
									check = dateTimeFormat(check,"mm/dd/yyyy hh:nn:ss aa");
							</cfscript>
							<tr>
								<td>#key#</td>
								<td class="text-right #theClass#">#check#</td>
							</tr>
						</cfloop>
					</tbody>
				</table>
			</section>
		</div>
	</body>
</html>
</cfoutput>
