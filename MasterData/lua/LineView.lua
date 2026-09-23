local num=12
function Awake()
    CreateLine(num,-400,400,-300,300,40,90,gameObject,{255,255,255,60})
end

function CreateLine(num,minX,maxX,minY,maxY,minTime,maxTime,parent,color)
	lines={};
	local pm=1;
	for i=1,num do
		local x=math.random( minX,maxX );
		local y=math.random( minY,maxY );
        local timer=math.random( minTime,maxTime );	
        pm=pm*-1;
		CSAPI.CreateGOAsync("UIs/Logo/Line",x,y,0,parent,function(go)
			pm=pm*-1;
			local angle=math.random( 0,180);
			CSAPI.SetAngle(go,0,0,angle*pm);
			angle=pm==1 and angle+180 or angle-180;
			CSAPI.SetImgColor(go,color[1],color[2],color[3],color[4]);
            local tween=ComUtil.GetCom(go,"ActionUIAngle");
            tween:PlayByTime(0, 0, angle,timer);
            -- CSAPI.RotateUITo(go.gameObject, "action_rotateUI_to_front2", 0, 0, angle, nil, timer)
            table.insert(lines,go);
		end);
	end
end

function OnDisable()
    lines=nil;
end