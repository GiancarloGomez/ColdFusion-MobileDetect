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

	param name="url.regex" default="";

	detect 		= new MobileDetect();
	version 	= detect.getVersion();
	deviceType 	= detect.isMobile() ? (detect.isTablet() ? "tablet" : "phone") : "computer";
	repoUrl 	= "https://github.com/GiancarloGomez/ColdFusion-MobileDetect/";
	// set detection type
	detect.setDetectionType(url.dt ?: "mobile");
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
				<a href="./session.cfm" class="pull-right btn btn-success">Session Example</a>
				<h1>
					<a href="#repoUrl#" target="blank">ColdFusion MobileDetect</a>
					<small>v. #version#</small>
				</h1>
			</header>
			<section>
				<p>The ColdFusion port of the lightweight <a href="https://github.com/serbanghita/Mobile-Detect" target="blank">Mobile_Detect PHP Library</a> for detecting mobile devices.</p>
				<div class="alert alert-info">
					<dl class="dl-horizontal">
						<dt>Device Type</dt>
						<dd>#deviceType#</dd>
						<dt>User Agent</dt>
						<dd>#cgi.HTTP_USER_AGENT#</dd>
					</dl>
				</div>
				<p class="text-success">
					Hint : Use your browser's developer tools to change and test your user agent.
				</p>
				<p>
					Please help me improve the mobile detection component by:
					<ol>
						<li><a href="#repoUrl#" target="blank">Forking the project</a></li>
						<li><a href="#repoUrl#/issues/new?body=#encodeForUrl(cgi.http_user_agent)#" target="blank">Submiting an issue</a></li>
					</ol>
				</p>
			</section>
			<section>
				<h3>Supported Methods</h3>

				<div class="well well-sm">
					<form action="./" method="GET" class="form-inline">
						<label class="control-label">DETECTION TYPE</label>
						<select class="form-control" name="dt" id="detection-type">
							<cfloop array="#detect.getDetectionTypes()#" index="type">
								<option value="#type#" #!compare(detect.getDetectionType(),type) ? 'selected' : ''#>#type#</option>
							</cfloop>
						</select>
					</form>
				</div>

				<table class="table table-striped">
					<thead>
						<tr>
							<th colspan="2">Basic Detection Methods <small class="text-muted">Most common use</small></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>isMobile()</td>
							<td class="text-right text-#detect.isMobile() ? 'success' : 'danger'#">#detect.isMobile()#</td>
						</tr>
						<tr>
							<td>isTablet()</td>
							<td class="text-right text-#detect.isTablet() ? 'success' : 'danger'#">#detect.isTablet()#</td>
						</tr>
						<tr>
							<td>isAndroid()</td>
							<td class="text-right text-#detect.isAndroid() ? 'success' : 'danger'#">#detect.isAndroid()#</td>
						</tr>
						<tr>
							<td>isiPhone()</td>
							<td class="text-right text-#detect.isiPhone() ? 'success' : 'danger'#">#detect.isiPhone()#</td>
						</tr>
						<tr>
							<td>isIOS()</td>
							<td class="text-right text-#detect.isTablet() ? 'success' : 'danger'#">#detect.isIOS()#</td>
						</tr>
					</tbody>
				</table>

				<div class="well well-sm">
					<form action="./demo.cfm" method="GET">
						<label class="control-label">Custom Detection Method</label>
						<div class="input-group">
							<input type="text" name="regex" value="#url.regex#" class="form-control" />
							<span class="input-group-btn">
								<button type="submit" class="btn btn-info">Submit</button>
							</span>
						</div>
						<span class="help-block">
							If you need to define a rule that is custom to just you, the match() function can
							be used to validate against a custom regex rule. For example to match only to
							Safari for Desktop you can use the following rule <code>Macintosh(.*)Version(.*)Safari</code>.
						</span>
						<cfif len(url.regex)>
							<table class="table table-striped" style="margin:0;">
								<tbody>
									<cfscript>
										check = detect.match(url.regex);
									</cfscript>
									<tr>
										<td class="text-muted">detect("#url.regex#")</td>
										<td class="text-right text-#check ? 'success':'danger'#">#check#</td>
									</tr>
								</tbody>
							</table>
						</cfif>
					</form>
				</div>

				<table class="table table-striped">
					<thead>
						<tr>
							<th colspan="2">
								<button type="button" class="btn btn-primary show-hide pull-right" data-target="no-match-custom">View All</button>
								Custom Detection Methods <small class="text-muted">All Built In Checks</small>
							</th>
						</tr>
					</thead>
					<tbody>
					<cfloop collection="#detect.getRules()#" item="rule">
						<cfscript>
							check = evaluate("detect.is#rule#()");
							// can also do detect._is(rule) but wanted to show using the isRule() syntaxt
						</cfscript>
						<tr class="#!check ? 'hide no-match-custom' : ''#">
							<td>is#rule#</td>
							<td class="text-right text-#check ? 'success':'danger'#">#check#</td>
						</tr>
					</cfloop>
					</tbody>
				</table>

				<table class="table table-striped">
					<thead>
						<tr>
							<th colspan="2">
								<button type="button" class="btn btn-primary show-hide pull-right" data-target="no-match-version">View All</button>
								Experimental version() method
							</th>
						</tr>
					</thead>
					<tbody>
						<cfloop collection="#detect.getProperties()#" item="property">
							<cfscript>
								check = detect.version(property);
							</cfscript>
							<tr class="#!len(check) ? 'hide no-match-version' : ''#">
								<td>#property#</td>
								<td class="text-right">#check#</td>
							</tr>
						</cfloop>
					</tbody>
				</table>

				<table class="table">
					<thead>
						<tr>
							<th>Debug</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>Matching Regex</th>
						</tr>
						<tr>
							<td>#detect.getMatchingRegex() ?: "[empty string]"#</td>
						</tr>
						<tr>
							<th>Matching Struct</th>
						</tr>
						<tr>
							<td><cfdump var="#detect.getMatchesStruct() ?: ""#"></td>
						</tr>
					</tbody>
				</table>
			</section>
		</div>
		<script>
			var items = {};

			// on detection type change redirect
			document.getElementById('detection-type').addEventListener('change',function(){
				window.location = window.location.pathname + '?dt=' + this.value;
			},false);
			// buttons
			Array.from(document.getElementsByClassName('show-hide')).forEach(function(btn){
				btn.addEventListener('click',handleButtonClick,false);
				items[btn.dataset.target] = Array.from(document.getElementsByClassName(btn.dataset.target));
			})
			// show/hide on button click
			function handleButtonClick(e){
				var btn 	= e.target,
					show 	= btn.innerHTML === 'View All';
				if (show === true)
					btn.innerHTML = 'View Matched';
				else
					btn.innerHTML = 'View All';

				items[btn.dataset.target].forEach(function(elem){
					if (show === true)
						elem.classList.remove('hide');
					else
						elem.classList.add('hide');
				})
			}
		</script>
	</body>
</html>
</cfoutput>
