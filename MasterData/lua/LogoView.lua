local whiteNum=6
local blackNum=4;
function Awake()
    CreateLine(whiteNum,-240,240,-40,40,10,60,layer1,{0,0,0,60})
    CreateLine(blackNum,-80,80,-5,5,10,40,layer2,{0,0,0,60})
end

function CreateLine(num,minX,maxX,minY,maxY,minTime,maxTime,parent,color)
	lines={};
	local pm=1;
	for i=1,num do
		local x=math.random( minX,maxX );
		local y=math.random( minY,maxY );
        local timer=math.random( minTime,maxTime );	
		CSAPI.CreateGOAsync("UIs/Logo/Line",x,y,0,parent,function(go)
			pm=pm*-1;
			local angle=math.random( 0,180);
			CSAPI.SetAngle(go,0,0,angle*pm);
			angle=pm==1 and angle+180 or angle-180;
            CSAPI.SetImgColor(go,color[1],color[2],color[3],color[4]);
            local tween=ComUtil.GetCom(go,"ActionUIAngle");
            tween:PlayByTime(0, 0, angle,timer);
            tween.autoPlay=true;
            table.insert(lines,go);
		end);
	end
end