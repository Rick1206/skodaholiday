package {
	import com.serialization.json.JSON;
	import fl.video.FLVPlayback;
	import fl.video.MetadataEvent;
	import fl.video.VideoScaleMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import asfiles.utils.Player;
	public class VideoPlayer extends Sprite {
		 
		public var flv:Player;
		public var control:Control;
		private var diyData:Object;
		public var cover:Sprite;
		public var waiting:Loading;
		private var flvContainer:Sprite;
		private var index:int = 0;
		private var sources:Array = ["dog/Dog.flv", "Reporter/Repoter.flv", "kiss/Kiss.flv"];
		
		private var dataLoader:URLLoader;
		
		private var trackData_kiss:String;// = '{"data":[[{"frame":116,"x":-253.918,"y":-378.6289},{"frame":117,"x":-237.918,"y":-366.6289},{"frame":118,"x":-221.918,"y":-354.6289},{"frame":119,"x":-205.918,"y":-342.6289},{"frame":120,"x":-189.918,"y":-330.6289},{"frame":121,"x":-173.918,"y":-318.6289},{"frame":122,"x":-157.918,"y":-306.6289},{"frame":123,"x":-141.918,"y":-294.6289},{"frame":124,"x":-125.918,"y":-282.6289},{"frame":125,"x":-109.918,"y":-270.6289},{"frame":126,"x":-93.918,"y":-258.6289},{"frame":127,"x":-77.918,"y":-246.6289},{"frame":128,"x":-61.918,"y":-234.6289},{"frame":129,"x":-45.918,"y":-222.6289},{"frame":130,"x":-29.918,"y":-210.6289},{"frame":131,"x":-13.918,"y":-198.6289},{"frame":132,"x":2.08199999999999,"y":-186.6289},{"frame":133,"x":18.082,"y":-174.6289},{"frame":134,"x":34.082,"y":-162.6289},{"frame":135,"x":50.082,"y":-150.6289},{"frame":136,"x":66.082,"y":-138.6289},{"frame":137,"x":82.082,"y":-126.6289},{"frame":138,"x":98.082,"y":-114.6289},{"frame":139,"x":114.082,"y":-102.6289},{"frame":140,"x":130.082,"y":-90.6289},{"frame":141,"x":146.082,"y":-78.6289},{"frame":142,"x":162.082,"y":-66.6289},{"frame":143,"x":178.082,"y":-54.6289},{"frame":144,"x":194.082,"y":-42.6289},{"frame":145,"x":210.082,"y":-30.6289},{"frame":146,"x":226.082,"y":-18.6289},{"frame":147,"x":242.082,"y":-6.6289},{"frame":148,"x":258.082,"y":5.3711},{"frame":149,"x":274.082,"y":17.3711},{"frame":150,"x":290.082,"y":29.3711},{"frame":151,"x":306.375,"y":42.3359},{"frame":152,"x":322.375,"y":54.375},{"frame":153,"x":338.074,"y":66.3516},{"frame":154,"x":352.371,"y":77.3555},{"frame":155,"x":366.375,"y":87.9453},{"frame":156,"x":379.465,"y":99.2617},{"frame":157,"x":392.242,"y":108.395},{"frame":158,"x":404.246,"y":118.352},{"frame":159,"x":415.406,"y":127.789},{"frame":160,"x":426.168,"y":135.875},{"frame":161,"x":435.875,"y":143.898},{"frame":162,"x":445.613,"y":151.879},{"frame":163,"x":454.375,"y":159.656},{"frame":164,"x":462.121,"y":166.363},{"frame":165,"x":469.457,"y":172.414},{"frame":166,"x":476.359,"y":179.273},{"frame":167,"x":482.453,"y":184.414},{"frame":168,"x":488.457,"y":190.344},{"frame":169,"x":494.293,"y":195.375},{"frame":170,"x":499.375,"y":199.789},{"frame":171,"x":503.457,"y":203.934},{"frame":172,"x":507.473,"y":208.242},{"frame":173,"x":511.375,"y":211.777},{"frame":174,"x":514.348,"y":215.711},{"frame":175,"x":516.617,"y":219.273},{"frame":176,"x":519.613,"y":221.375},{"frame":177,"x":520.766,"y":223.832},{"frame":178,"x":522.375,"y":226.992},{"frame":179,"x":523.23,"y":228.344},{"frame":180,"x":523.363,"y":230.34},{"frame":181,"x":523.367,"y":231.621},{"frame":182,"x":523.488,"y":232.445},{"frame":183,"x":524.051,"y":234.352},{"frame":184,"x":524.223,"y":235.695},{"frame":185,"x":524.238,"y":236.383},{"frame":186,"x":524.234,"y":237.375},{"frame":187,"x":524.234,"y":239.234},{"frame":188,"x":524.289,"y":239.633},{"frame":189,"x":524.367,"y":240.105},{"frame":190,"x":524.371,"y":241.27},{"frame":191,"x":524.375,"y":242.23},{"frame":192,"x":524.375,"y":242.566},{"frame":193,"x":524.375,"y":243.191},{"frame":194,"x":524.375,"y":243.605},{"frame":195,"x":524.375,"y":243.703},{"frame":196,"x":524.375,"y":243.82},{"frame":197,"x":524.379,"y":244.375},{"frame":198,"x":524.391,"y":244.375},{"frame":199,"x":524.418,"y":244.914},{"frame":200,"x":524.441,"y":245.355},{"frame":201,"x":524.441,"y":245.355},{"frame":202,"x":524.43,"y":245.355},{"frame":203,"x":524.375,"y":245.355},{"frame":204,"x":524.375,"y":245.359},{"frame":205,"x":524.375,"y":245.359},{"frame":206,"x":524.375,"y":245.273},{"frame":207,"x":524.375,"y":244.375},{"frame":208,"x":524.375,"y":244.375},{"frame":209,"x":524.375,"y":244.375},{"frame":210,"x":524.375,"y":243.777},{"frame":211,"x":524.375,"y":243.66},{"frame":212,"x":524.375,"y":243.598},{"frame":213,"x":524.387,"y":243.633},{"frame":214,"x":524.414,"y":243.246},{"frame":215,"x":524.41,"y":243.246},{"frame":216,"x":524.398,"y":242.34},{"frame":217,"x":524.391,"y":241.941},{"frame":218,"x":524.371,"y":241.355},{"frame":219,"x":524.363,"y":240.375},{"frame":220,"x":524.355,"y":240.148},{"frame":221,"x":524.336,"y":239.656},{"frame":222,"x":524.23,"y":239.543},{"frame":223,"x":524.188,"y":239.199},{"frame":224,"x":524.215,"y":238.375},{"frame":225,"x":524.152,"y":238.324},{"frame":226,"x":524.129,"y":237.359},{"frame":227,"x":524.113,"y":236.375},{"frame":228,"x":524.164,"y":236.145},{"frame":229,"x":524.258,"y":235.719},{"frame":230,"x":524.223,"y":235.719},{"frame":231,"x":524.172,"y":235.27},{"frame":232,"x":524.145,"y":234.996},{"frame":233,"x":524.039,"y":234.355},{"frame":234,"x":523.797,"y":233.375},{"frame":235,"x":523.98,"y":233.352},{"frame":236,"x":523.797,"y":232.398},{"frame":237,"x":523.66,"y":232.137},{"frame":238,"x":523.625,"y":231.75},{"frame":239,"x":523.586,"y":231.625},{"frame":240,"x":523.551,"y":231.598},{"frame":241,"x":523.547,"y":231.375},{"frame":242,"x":523.641,"y":231.273},{"frame":243,"x":523.699,"y":231.293},{"frame":244,"x":523.738,"y":230.863},{"frame":245,"x":523.73,"y":230.375},{"frame":246,"x":523.738,"y":230.375},{"frame":247,"x":523.738,"y":230.375},{"frame":248,"x":523.738,"y":230.375},{"frame":249,"x":523.738,"y":230.375},{"frame":250,"x":523.738,"y":230.375},{"frame":251,"x":523.691,"y":230.375},{"frame":252,"x":523.375,"y":230.34},{"frame":253,"x":523.285,"y":230.141},{"frame":254,"x":523.367,"y":230.34},{"frame":255,"x":523.535,"y":230.492},{"frame":256,"x":523.871,"y":230.563},{"frame":257,"x":523.875,"y":230.566},{"frame":258,"x":523.836,"y":230.5},{"frame":259,"x":523.77,"y":230.438},{"frame":260,"x":523.809,"y":230.426},{"frame":261,"x":523.801,"y":230.426},{"frame":262,"x":523.793,"y":230.41},{"frame":263,"x":523.813,"y":230.438},{"frame":264,"x":523.789,"y":230.434},{"frame":265,"x":523.707,"y":230.34},{"frame":266,"x":523.613,"y":230.34},{"frame":267,"x":523.617,"y":230.34},{"frame":268,"x":523.629,"y":230.34},{"frame":269,"x":523.625,"y":230.34},{"frame":270,"x":523.625,"y":230.34},{"frame":271,"x":523.617,"y":230.34},{"frame":272,"x":523.617,"y":230.34},{"frame":273,"x":523.613,"y":230.34},{"frame":274,"x":523.617,"y":230.34},{"frame":275,"x":523.684,"y":230.34}],[{"frame":116,"x":195.145,"y":-207.0312},{"frame":117,"x":206.145,"y":-200.0312},{"frame":118,"x":217.145,"y":-193.0312},{"frame":119,"x":228.145,"y":-186.0312},{"frame":120,"x":239.145,"y":-179.0312},{"frame":121,"x":250.145,"y":-172.0312},{"frame":122,"x":261.145,"y":-165.0312},{"frame":123,"x":272.145,"y":-158.0312},{"frame":124,"x":283.145,"y":-151.0312},{"frame":125,"x":294.145,"y":-144.0312},{"frame":126,"x":305.145,"y":-137.0312},{"frame":127,"x":316.145,"y":-130.0312},{"frame":128,"x":327.145,"y":-123.0312},{"frame":129,"x":338.145,"y":-116.0312},{"frame":130,"x":349.145,"y":-109.0312},{"frame":131,"x":360.145,"y":-102.0312},{"frame":132,"x":371.145,"y":-95.0312},{"frame":133,"x":382.145,"y":-88.0312},{"frame":134,"x":393.145,"y":-81.0312},{"frame":135,"x":404.145,"y":-74.0312},{"frame":136,"x":415.145,"y":-67.0312},{"frame":137,"x":426.145,"y":-60.0312},{"frame":138,"x":437.145,"y":-53.0312},{"frame":139,"x":448.145,"y":-46.0312},{"frame":140,"x":459.145,"y":-39.0312},{"frame":141,"x":470.145,"y":-32.0312},{"frame":142,"x":481.145,"y":-25.0312},{"frame":143,"x":492.145,"y":-18.0312},{"frame":144,"x":503.145,"y":-11.0312},{"frame":145,"x":514.145,"y":-4.0312},{"frame":146,"x":525.145,"y":2.9688},{"frame":147,"x":536.145,"y":9.9688},{"frame":148,"x":547.145,"y":16.9688},{"frame":149,"x":558.145,"y":23.9688},{"frame":150,"x":569.422,"y":30.9688},{"frame":151,"x":580.023,"y":43.8164},{"frame":152,"x":590.199,"y":55.8164},{"frame":153,"x":600.008,"y":67.8086},{"frame":154,"x":609,"y":78.9453},{"frame":155,"x":617.492,"y":89.1172},{"frame":156,"x":625.539,"y":99.9258},{"frame":157,"x":633.027,"y":109.93},{"frame":158,"x":640.043,"y":119.141},{"frame":159,"x":646.688,"y":128.379},{"frame":160,"x":652.789,"y":137.035},{"frame":161,"x":657.355,"y":145.082},{"frame":162,"x":663.387,"y":153.039},{"frame":163,"x":668.195,"y":160.469},{"frame":164,"x":672.98,"y":167.805},{"frame":165,"x":676.426,"y":174},{"frame":166,"x":680.949,"y":180},{"frame":167,"x":683.773,"y":185.957},{"frame":168,"x":686.922,"y":191.086},{"frame":169,"x":690.262,"y":196.008},{"frame":170,"x":693.398,"y":200.906},{"frame":171,"x":695.543,"y":205.031},{"frame":172,"x":697.512,"y":209.199},{"frame":173,"x":699.422,"y":212.676},{"frame":174,"x":701.094,"y":216.594},{"frame":175,"x":702.66,"y":220.063},{"frame":176,"x":703.438,"y":222.98},{"frame":177,"x":704.801,"y":225.137},{"frame":178,"x":704.688,"y":227.992},{"frame":179,"x":705.715,"y":229.832},{"frame":180,"x":706.141,"y":231.977},{"frame":181,"x":706.621,"y":233.188},{"frame":182,"x":706.637,"y":233.926},{"frame":183,"x":706.84,"y":236.008},{"frame":184,"x":706.68,"y":237.188},{"frame":185,"x":707.395,"y":237.875},{"frame":186,"x":707.527,"y":239.18},{"frame":187,"x":707.504,"y":240.828},{"frame":188,"x":707.484,"y":241.27},{"frame":189,"x":707.488,"y":241.434},{"frame":190,"x":707.551,"y":242.949},{"frame":191,"x":707.664,"y":243.871},{"frame":192,"x":707.832,"y":244.34},{"frame":193,"x":707.309,"y":244.801},{"frame":194,"x":707.852,"y":245.148},{"frame":195,"x":707.359,"y":245.453},{"frame":196,"x":707.91,"y":245.535},{"frame":197,"x":707.445,"y":246.195},{"frame":198,"x":708.016,"y":245.887},{"frame":199,"x":707.988,"y":246.531},{"frame":200,"x":707.484,"y":247.16},{"frame":201,"x":707.957,"y":247.191},{"frame":202,"x":707.414,"y":246.852},{"frame":203,"x":707.949,"y":247.199},{"frame":204,"x":707.445,"y":246.836},{"frame":205,"x":707.988,"y":247.168},{"frame":206,"x":707.477,"y":246.898},{"frame":207,"x":707.969,"y":246.254},{"frame":208,"x":707.438,"y":245.879},{"frame":209,"x":707.93,"y":246.215},{"frame":210,"x":707.34,"y":245.195},{"frame":211,"x":707.84,"y":245.121},{"frame":212,"x":707.293,"y":245.301},{"frame":213,"x":707.84,"y":244.867},{"frame":214,"x":707.301,"y":244.809},{"frame":215,"x":707.84,"y":244.758},{"frame":216,"x":707.262,"y":243.895},{"frame":217,"x":707.84,"y":243.402},{"frame":218,"x":707.199,"y":242.984},{"frame":219,"x":707.789,"y":242.098},{"frame":220,"x":707.152,"y":241.703},{"frame":221,"x":707.75,"y":241.313},{"frame":222,"x":707.152,"y":240.914},{"frame":223,"x":707.816,"y":240.66},{"frame":224,"x":707.164,"y":239.926},{"frame":225,"x":707.801,"y":239.887},{"frame":226,"x":707.141,"y":238.992},{"frame":227,"x":707.637,"y":238.137},{"frame":228,"x":707.527,"y":237.785},{"frame":229,"x":707.371,"y":237.395},{"frame":230,"x":707.184,"y":237.09},{"frame":231,"x":707.004,"y":236.789},{"frame":232,"x":706.844,"y":236.469},{"frame":233,"x":706.242,"y":235.91},{"frame":234,"x":706.754,"y":235.109},{"frame":235,"x":706.172,"y":234.91},{"frame":236,"x":706.762,"y":234.164},{"frame":237,"x":706.188,"y":233.637},{"frame":238,"x":706.84,"y":233.133},{"frame":239,"x":706.359,"y":232.789},{"frame":240,"x":706.84,"y":232.797},{"frame":241,"x":706.223,"y":232.773},{"frame":242,"x":706.84,"y":232.629},{"frame":243,"x":706.203,"y":232.656},{"frame":244,"x":706.727,"y":232.203},{"frame":245,"x":706.668,"y":231.691},{"frame":246,"x":706.68,"y":231.949},{"frame":247,"x":706.684,"y":231.918},{"frame":248,"x":706.688,"y":231.918},{"frame":249,"x":706.648,"y":231.953},{"frame":250,"x":706.738,"y":231.91},{"frame":251,"x":706.84,"y":231.836},{"frame":252,"x":706.965,"y":231.766},{"frame":253,"x":706.965,"y":231.91},{"frame":254,"x":706.844,"y":231.988},{"frame":255,"x":706.828,"y":232.137},{"frame":256,"x":706.828,"y":232.141},{"frame":257,"x":706.828,"y":232.141},{"frame":258,"x":706.871,"y":232.039},{"frame":259,"x":706.844,"y":232},{"frame":260,"x":706.832,"y":232.023},{"frame":261,"x":706.844,"y":232.078},{"frame":262,"x":706.84,"y":232.063},{"frame":263,"x":706.84,"y":231.973},{"frame":264,"x":706.883,"y":231.996},{"frame":265,"x":706.953,"y":231.926},{"frame":266,"x":706.965,"y":231.926},{"frame":267,"x":706.961,"y":231.926},{"frame":268,"x":706.953,"y":231.926},{"frame":269,"x":706.949,"y":231.93},{"frame":270,"x":706.941,"y":231.926},{"frame":271,"x":706.938,"y":231.93},{"frame":272,"x":706.934,"y":231.93},{"frame":273,"x":706.934,"y":231.926},{"frame":274,"x":706.949,"y":231.93},{"frame":275,"x":706.965,"y":231.93}],[{"frame":116,"x":-376.6328,"y":30.387},{"frame":117,"x":-356.6328,"y":38.387},{"frame":118,"x":-336.6328,"y":46.387},{"frame":119,"x":-316.6328,"y":54.387},{"frame":120,"x":-296.6328,"y":62.387},{"frame":121,"x":-276.6328,"y":70.387},{"frame":122,"x":-256.6328,"y":78.387},{"frame":123,"x":-236.6328,"y":86.387},{"frame":124,"x":-216.6328,"y":94.387},{"frame":125,"x":-196.6328,"y":102.387},{"frame":126,"x":-176.6328,"y":110.387},{"frame":127,"x":-156.6328,"y":118.387},{"frame":128,"x":-136.6328,"y":126.387},{"frame":129,"x":-116.6328,"y":134.387},{"frame":130,"x":-96.6328,"y":142.387},{"frame":131,"x":-76.6328,"y":150.387},{"frame":132,"x":-56.6328,"y":158.387},{"frame":133,"x":-36.6328,"y":166.387},{"frame":134,"x":-16.6328,"y":174.387},{"frame":135,"x":3.3672,"y":182.387},{"frame":136,"x":23.3672,"y":190.387},{"frame":137,"x":43.3672,"y":198.387},{"frame":138,"x":63.2109,"y":206.379},{"frame":139,"x":83.2422,"y":215.113},{"frame":140,"x":102.238,"y":224.172},{"frame":141,"x":121.25,"y":232.703},{"frame":142,"x":140.748,"y":240.834},{"frame":143,"x":160.246,"y":248.965},{"frame":144,"x":180.184,"y":258.422},{"frame":145,"x":199.684,"y":265.629},{"frame":146,"x":218.242,"y":273.684},{"frame":147,"x":237.832,"y":281.449},{"frame":148,"x":256.188,"y":288.918},{"frame":149,"x":274.102,"y":296.91},{"frame":150,"x":291.25,"y":304.246},{"frame":151,"x":307.23,"y":311.375},{"frame":152,"x":324.02,"y":316.438},{"frame":153,"x":339.23,"y":323.191},{"frame":154,"x":353.859,"y":329.09},{"frame":155,"x":367.699,"y":335.371},{"frame":156,"x":380.301,"y":339.539},{"frame":157,"x":393.078,"y":344},{"frame":158,"x":405.461,"y":349.5},{"frame":159,"x":416.109,"y":353.516},{"frame":160,"x":427.098,"y":357.609},{"frame":161,"x":437.063,"y":361.668},{"frame":162,"x":446.102,"y":365.52},{"frame":163,"x":455.043,"y":369.285},{"frame":164,"x":463.02,"y":372.676},{"frame":165,"x":470.863,"y":375.867},{"frame":166,"x":477.453,"y":380.117},{"frame":167,"x":483.328,"y":382.547},{"frame":168,"x":489.289,"y":384.613},{"frame":169,"x":495.102,"y":387.359},{"frame":170,"x":500.25,"y":389.621},{"frame":171,"x":504.25,"y":392.102},{"frame":172,"x":508.25,"y":395.422},{"frame":173,"x":512,"y":396.16},{"frame":174,"x":515.25,"y":399.43},{"frame":175,"x":517.25,"y":400.199},{"frame":176,"x":519.512,"y":403.453},{"frame":177,"x":521.25,"y":404},{"frame":178,"x":522.98,"y":406.516},{"frame":179,"x":523.695,"y":407.387},{"frame":180,"x":524.25,"y":408.902},{"frame":181,"x":524.25,"y":411.422},{"frame":182,"x":524.25,"y":411.809},{"frame":183,"x":524.25,"y":413.57},{"frame":184,"x":524.605,"y":414.531},{"frame":185,"x":524.98,"y":415.34},{"frame":186,"x":525.25,"y":416.039},{"frame":187,"x":525.105,"y":417.883},{"frame":188,"x":525.25,"y":419.379},{"frame":189,"x":525.129,"y":419.285},{"frame":190,"x":525.25,"y":419.625},{"frame":191,"x":525.219,"y":420.063},{"frame":192,"x":525.492,"y":421.547},{"frame":193,"x":525.25,"y":421.633},{"frame":194,"x":525.25,"y":422.547},{"frame":195,"x":525.25,"y":422.613},{"frame":196,"x":525.25,"y":423.316},{"frame":197,"x":525.285,"y":423.344},{"frame":198,"x":525.34,"y":423.582},{"frame":199,"x":525.363,"y":423.504},{"frame":200,"x":525.367,"y":423.449},{"frame":201,"x":525.367,"y":423.684},{"frame":202,"x":525.359,"y":423.977},{"frame":203,"x":525.32,"y":424.758},{"frame":204,"x":525.324,"y":424.688},{"frame":205,"x":525.355,"y":423.707},{"frame":206,"x":525.363,"y":423.566},{"frame":207,"x":525.359,"y":423.566},{"frame":208,"x":525.355,"y":423.582},{"frame":209,"x":525.313,"y":423.293},{"frame":210,"x":525.266,"y":423.324},{"frame":211,"x":525.25,"y":423.02},{"frame":212,"x":525.25,"y":423.406},{"frame":213,"x":525.25,"y":422.246},{"frame":214,"x":525.25,"y":422.43},{"frame":215,"x":525.25,"y":420.879},{"frame":216,"x":525.25,"y":421.453},{"frame":217,"x":525.234,"y":419.98},{"frame":218,"x":525.41,"y":420.438},{"frame":219,"x":525.176,"y":419.508},{"frame":220,"x":525.336,"y":419.219},{"frame":221,"x":525.141,"y":419.375},{"frame":222,"x":525.273,"y":418.465},{"frame":223,"x":525.121,"y":417.578},{"frame":224,"x":525.25,"y":416.742},{"frame":225,"x":525.098,"y":416.137},{"frame":226,"x":525.25,"y":416.875},{"frame":227,"x":524.918,"y":416.531},{"frame":228,"x":525.234,"y":415.574},{"frame":229,"x":524.969,"y":415.023},{"frame":230,"x":524.922,"y":415.559},{"frame":231,"x":524.75,"y":413.816},{"frame":232,"x":524.492,"y":413.695},{"frame":233,"x":524.25,"y":412.969},{"frame":234,"x":524.25,"y":413.004},{"frame":235,"x":524.25,"y":412.586},{"frame":236,"x":524.25,"y":411.875},{"frame":237,"x":524.25,"y":412.191},{"frame":238,"x":524.277,"y":411.66},{"frame":239,"x":524.328,"y":410.508},{"frame":240,"x":524.355,"y":410.203},{"frame":241,"x":524.359,"y":410.395},{"frame":242,"x":524.359,"y":409.496},{"frame":243,"x":524.359,"y":408.852},{"frame":244,"x":524.355,"y":409.422},{"frame":245,"x":524.352,"y":408.602},{"frame":246,"x":524.355,"y":408.59},{"frame":247,"x":524.352,"y":408.629},{"frame":248,"x":524.266,"y":408.746},{"frame":249,"x":524.25,"y":409.234},{"frame":250,"x":524.309,"y":409.469},{"frame":251,"x":524.348,"y":408.652},{"frame":252,"x":524.344,"y":408.637},{"frame":253,"x":524.313,"y":408.688},{"frame":254,"x":524.25,"y":408.805},{"frame":255,"x":524.25,"y":409.574},{"frame":256,"x":524.25,"y":409},{"frame":257,"x":524.25,"y":409.84},{"frame":258,"x":524.25,"y":409.613},{"frame":259,"x":524.25,"y":408.762},{"frame":260,"x":524.254,"y":409.5},{"frame":261,"x":524.25,"y":408.75},{"frame":262,"x":524.25,"y":409.516},{"frame":263,"x":524.25,"y":408.75},{"frame":264,"x":524.25,"y":409.516},{"frame":265,"x":524.25,"y":408.957},{"frame":266,"x":524.25,"y":409.68},{"frame":267,"x":524.25,"y":409},{"frame":268,"x":524.25,"y":409.695},{"frame":269,"x":524.25,"y":409},{"frame":270,"x":524.25,"y":409.703},{"frame":271,"x":524.25,"y":409},{"frame":272,"x":524.25,"y":409.707},{"frame":273,"x":524.25,"y":409},{"frame":274,"x":524.25,"y":409.695},{"frame":275,"x":524.25,"y":409}],[{"frame":116,"x":71.8945,"y":22.1797},{"frame":117,"x":84.7891,"y":28.9648},{"frame":118,"x":97.9688,"y":36.8008},{"frame":119,"x":111.797,"y":44.125},{"frame":120,"x":125.809,"y":51.1523},{"frame":121,"x":140.457,"y":59.1367},{"frame":122,"x":154.926,"y":67.1484},{"frame":123,"x":169.973,"y":75.1445},{"frame":124,"x":185.395,"y":83.5742},{"frame":125,"x":200.805,"y":92.1016},{"frame":126,"x":216.664,"y":100.738},{"frame":127,"x":232.652,"y":109.008},{"frame":128,"x":248.652,"y":118.02},{"frame":129,"x":264.656,"y":127.152},{"frame":130,"x":280.777,"y":136.137},{"frame":131,"x":296.793,"y":144.977},{"frame":132,"x":312.852,"y":153.66},{"frame":133,"x":328.953,"y":163.148},{"frame":134,"x":344.898,"y":172.152},{"frame":135,"x":360.793,"y":180.707},{"frame":136,"x":376.668,"y":189.457},{"frame":137,"x":392.484,"y":199.09},{"frame":138,"x":407.684,"y":208.094},{"frame":139,"x":422.785,"y":216.828},{"frame":140,"x":437.777,"y":225.027},{"frame":141,"x":452.77,"y":233.316},{"frame":142,"x":466.988,"y":242.164},{"frame":143,"x":481.68,"y":250.492},{"frame":144,"x":495.773,"y":259.152},{"frame":145,"x":509.398,"y":267.188},{"frame":146,"x":522.777,"y":275.258},{"frame":147,"x":535.75,"y":283.152},{"frame":148,"x":547.777,"y":290.645},{"frame":149,"x":559.758,"y":297.785},{"frame":150,"x":570.859,"y":305.414},{"frame":151,"x":581.75,"y":312.125},{"frame":152,"x":591.809,"y":318.125},{"frame":153,"x":601.281,"y":325.125},{"frame":154,"x":610.75,"y":330.113},{"frame":155,"x":618.816,"y":336.125},{"frame":156,"x":626.781,"y":341.125},{"frame":157,"x":634.609,"y":345.316},{"frame":158,"x":641.098,"y":350.168},{"frame":159,"x":647.781,"y":355.152},{"frame":160,"x":653.785,"y":359.164},{"frame":161,"x":659.781,"y":363.188},{"frame":162,"x":664.848,"y":367.148},{"frame":163,"x":669.773,"y":370.938},{"frame":164,"x":674.691,"y":374.184},{"frame":165,"x":678.707,"y":377.199},{"frame":166,"x":682.695,"y":380.867},{"frame":167,"x":685.781,"y":383.211},{"frame":168,"x":688.938,"y":386.125},{"frame":169,"x":691.773,"y":388.953},{"frame":170,"x":694.711,"y":391.156},{"frame":171,"x":696.957,"y":393.332},{"frame":172,"x":698.992,"y":396.125},{"frame":173,"x":700.93,"y":397.352},{"frame":174,"x":702.766,"y":400.125},{"frame":175,"x":703.785,"y":401.367},{"frame":176,"x":704.984,"y":404.125},{"frame":177,"x":705.816,"y":405.199},{"frame":178,"x":706.781,"y":407.156},{"frame":179,"x":706.945,"y":408.91},{"frame":180,"x":707.535,"y":410.168},{"frame":181,"x":707.777,"y":412.125},{"frame":182,"x":707.781,"y":412.949},{"frame":183,"x":707.781,"y":414.172},{"frame":184,"x":707.785,"y":416.102},{"frame":185,"x":707.789,"y":416.832},{"frame":186,"x":707.961,"y":417.281},{"frame":187,"x":708.391,"y":418.441},{"frame":188,"x":708.668,"y":420.098},{"frame":189,"x":708.664,"y":420.805},{"frame":190,"x":708.668,"y":420.957},{"frame":191,"x":708.703,"y":421.344},{"frame":192,"x":708.766,"y":422.191},{"frame":193,"x":708.766,"y":423.156},{"frame":194,"x":708.77,"y":424.125},{"frame":195,"x":708.773,"y":424.125},{"frame":196,"x":708.75,"y":424.949},{"frame":197,"x":708.762,"y":424.992},{"frame":198,"x":708.777,"y":425.078},{"frame":199,"x":708.781,"y":425.008},{"frame":200,"x":708.781,"y":424.945},{"frame":201,"x":708.785,"y":425.125},{"frame":202,"x":708.793,"y":425.195},{"frame":203,"x":708.805,"y":425.246},{"frame":204,"x":708.809,"y":425.211},{"frame":205,"x":708.797,"y":425.156},{"frame":206,"x":708.793,"y":425.066},{"frame":207,"x":708.789,"y":425.063},{"frame":208,"x":708.781,"y":425.031},{"frame":209,"x":708.762,"y":424.859},{"frame":210,"x":708.754,"y":424.828},{"frame":211,"x":708.77,"y":424.273},{"frame":212,"x":708.695,"y":424.098},{"frame":213,"x":708.664,"y":423.578},{"frame":214,"x":708.66,"y":423.152},{"frame":215,"x":708.656,"y":422.223},{"frame":216,"x":708.656,"y":422.164},{"frame":217,"x":708.652,"y":421.258},{"frame":218,"x":708.652,"y":421.125},{"frame":219,"x":708.652,"y":420.777},{"frame":220,"x":708.652,"y":420.73},{"frame":221,"x":708.656,"y":420.09},{"frame":222,"x":708.648,"y":420.082},{"frame":223,"x":708.52,"y":419.141},{"frame":224,"x":708.215,"y":418.145},{"frame":225,"x":707.992,"y":417.305},{"frame":226,"x":707.867,"y":417.266},{"frame":227,"x":707.805,"y":416.844},{"frame":228,"x":707.777,"y":416.781},{"frame":229,"x":707.789,"y":416.133},{"frame":230,"x":707.789,"y":416.133},{"frame":231,"x":707.789,"y":415.16},{"frame":232,"x":707.789,"y":414.227},{"frame":233,"x":707.801,"y":414.125},{"frame":234,"x":707.793,"y":413.527},{"frame":235,"x":707.777,"y":413.406},{"frame":236,"x":707.773,"y":413.406},{"frame":237,"x":707.773,"y":413.125},{"frame":238,"x":707.777,"y":412.434},{"frame":239,"x":707.781,"y":412.145},{"frame":240,"x":707.75,"y":411.871},{"frame":241,"x":707.75,"y":411.16},{"frame":242,"x":707.715,"y":411.156},{"frame":243,"x":707.672,"y":410.383},{"frame":244,"x":707.641,"y":410.176},{"frame":245,"x":707.59,"y":410.168},{"frame":246,"x":707.48,"y":410.156},{"frame":247,"x":707.547,"y":410.172},{"frame":248,"x":708.039,"y":390.141},{"frame":249,"x":707.742,"y":410.313},{"frame":250,"x":707.648,"y":410.219},{"frame":251,"x":707.602,"y":410.184},{"frame":252,"x":707.652,"y":410.289},{"frame":253,"x":707.719,"y":410.297},{"frame":254,"x":707.727,"y":410.297},{"frame":255,"x":707.809,"y":410.297},{"frame":256,"x":707.914,"y":410.297},{"frame":257,"x":707.926,"y":410.387},{"frame":258,"x":707.672,"y":410.289},{"frame":259,"x":707.672,"y":410.242},{"frame":260,"x":707.672,"y":410.297},{"frame":261,"x":707.691,"y":410.297},{"frame":262,"x":707.676,"y":410.266},{"frame":263,"x":707.672,"y":410.262},{"frame":264,"x":707.695,"y":410.297},{"frame":265,"x":707.719,"y":410.297},{"frame":266,"x":707.727,"y":410.297},{"frame":267,"x":707.727,"y":410.297},{"frame":268,"x":707.727,"y":410.297},{"frame":269,"x":707.742,"y":410.297},{"frame":270,"x":707.738,"y":410.297},{"frame":271,"x":707.738,"y":410.297},{"frame":272,"x":707.738,"y":410.297},{"frame":273,"x":707.691,"y":410.297},{"frame":274,"x":707.672,"y":410.297},{"frame":275,"x":707.672,"y":410.297}]]}';
		public function VideoPlayer():void {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			index = this.loaderInfo.parameters['index']?loaderInfo.parameters['index']:index;
			
			cover.visible = false;
			flvContainer = new Sprite();
			addChild(flvContainer);
			
			flv = new Player();
			flv.setSize(540,303);
			
			//flv.scaleMode = VideoScaleMode.EXACT_FIT;
			//flv.fullScreenTakeOver = false;
			
			//flv.autoPlay = false;
			
			control = new Control();
			control.index = index;
			control.flv = flv;
			control.waiting = waiting;
			
			
			
			control.cover = cover;
			addChild(control);
			addChild(cover);
			cover.mouseChildren = cover.mouseEnabled = false;
			
		//	flv.activeVideoPlayerIndex =0;
		//	flv.getVideoPlayer(0).smoothing = true;
			
			if(ExternalInterface.available){
				diyData = JSON.deserialize(ExternalInterface.call("getVoteData"));
				//ExternalInterface.call("alert",diyData);
			} else {
				diyData = JSON.deserialize('["这里是昵称哦","http://tp4.sinaimg.cn/2029280671/180/5609952634/1"]');
			}
			
			(cover['img'] as ImageContainer).index = index;
			
			switch(index){
				case 0: 
					(cover['img'] as ImageContainer).containerWidth = 103;
					(cover['img'] as ImageContainer).containerHeight = 103;
					break;
				case 1:
					 
					(cover['img'] as ImageContainer).containerWidth = 178;
					(cover['img'] as ImageContainer).containerHeight = 178;
					break;
				default:
					cover['img'].visible = false;
					break;
			}
			
			if(diyData){
				cover['img'].src=diyData[1];
				cover['img'].nickname = diyData[0];
			}
			
			if (index > 1) {
				dataLoader = new URLLoader();
				dataLoader.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
				dataLoader.load(new URLRequest("data.txt"));
				//control.trackingData = JSON.deserialize(trackData_kiss).data;
			}else {
				flv.addEventListener(MetadataEvent.CUE_POINT, onEnddingHandler);
				flvContainer.addChild(flv);
				flv.play(sources[index]);
			}
			removeEventListener(Event.ADDED_TO_STAGE, init);
		 
			waiting = new Loading();
			addChild(waiting);
			
			flv.loading = waiting;
			resize();
			
			
			stage.addEventListener(Event.RESIZE, onResizeHandler);
		}
		
		private function onLoadCompleteHandler(e:Event):void 
		{
			control.trackingData = JSON.deserialize(e.target.data).data;
			flv.addEventListener(MetadataEvent.CUE_POINT, onEnddingHandler);
			flvContainer.addChild(flv);
			flv.play(sources[index]);
		}
		
		function onEnddingHandler(evt:MetadataEvent):void {
			trace("CUE POINT!!!");
			
			for (var s:String in evt.info) {
				trace("\t", s+":", evt.info[s]); // name: cuePoint1
			}
			 
			switch(evt.info.name) {
				case "endding":
					cover.visible = false;
					 
					break;
			}
		}
		
		private function onResizeHandler(e:Event):void 
		{
			resize();
		}
		
		private function resize():void 
		{
			var scale:Number = Math.min(stage.stageWidth / 540, (stage.stageHeight - 63) / 303);
			var flvWidth:Number = 540 * scale;
			var flvHeight:Number= 303 * scale;
			/*flv.width = flvWidth;
			flv.height = flvHeight;*/
			flv.setSize(flvWidth, flvHeight);
			flv.x = (stage.stageWidth - flvWidth) / 2;
			flv.y = (stage.stageHeight - 63 - flvHeight) / 2;
			
			cover.x = flv.x;
			cover.y = flv.y;
			waiting.x = stage.stageWidth / 2;
			waiting.y = flv.y + flvHeight / 2;
			
			switch(index){
				case 0:
					cover['img'].x = 197 * flvWidth/1280//+flv.x;
					cover['img'].y = 205 * flvWidth/1280//+flv.y;
					cover['img'].scaleX = Math.min(flvWidth/1280,flvHeight/720);
					cover['img'].scaleY =  Math.min(flvWidth/1280,flvHeight/720);
					cover['img'].rotation = -20;
					 
					break;
				case 1:
					cover['img'].x = 53 * flvWidth/1280//+flv.x;
					cover['img'].y = 311 * flvWidth / 1280//+flv.y;
					cover['img'].scaleX = Math.min(flvWidth/1280,flvHeight/720);
					cover['img'].scaleY =  Math.min(flvWidth / 1280, flvHeight / 720);
					 
					break;
			}
			control.y = stage.stageHeight - 63;
			 
			control.resize();
			
		}
		
		 
	}
}