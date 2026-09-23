function Awake()
	mSlider = ComUtil.GetCom(Slider, "Slider")
	mAnimSlider = ComUtil.GetCom(Slider, "SliderValue")
end

function Refresh(_data, _cur)
	cfg = _data.cfg
	cur = _cur
	
	isGet = _data.index >= 10000
	CSAPI.SetGOActive(star, not isGet)
	CSAPI.SetGOActive(success, isGet)
	if(not isGet) then
		CSAPI.SetText(txtStar, "x" .. cfg.star)
		mSlider.value = cur / cfg.star
	end
	
	if(canvasGroup == nil) then
		canvasGroup = ComUtil.GetCom(node, "CanvasGroup")
	end
	canvasGroup.alpha = _data.index >= 10000 and 0.3 or 1
	
	SetReward(cfg.jAwardId)
end

function SetReward(rewards)
	grids = grids and grids or {}
	for i, v in ipairs(grids) do
		CSAPI.SetGOActive(v.gameObject, false)
	end
	local item, go = nil, nil
	for i = 1, 3 do
		if(i <= #grids) then
			item = grids[i]
			CSAPI.SetGOActive(item.gameObject, true)
		else
			go, item = ResUtil:CreateRewardGrid(hLayout.transform)
			table.insert(grids, item)
		end
		local _data = i <= #rewards and rewards[i] or nil
		if(_data) then
			local data = {id = _data[1], type = _data[3], num = _data[2]}
			local result, clickCB = GridFakeData(data)
			item.Refresh(result)
			item.SetClickCB(clickCB)
			item.SetCount(data.num)
		else
			item.Refresh(nil, {plus = false})
			item.SetClickCB(nil)
		end
	end
end

function SetFakeAnim(cur)
	--slider 
	local targetValue = cur / cfg.star
	if(targetValue > mSlider.value) then
		mAnimSlider:SetCurToValue(targetValue, 0.3, 0.5, SliderCB)
	end
	if(targetValue >= 1 and not isGet) then
		FuncUtil:Call(function()
			CSAPI.SetGOActive(gameObject, false)
		end, nil, 800)
	end
end

function SliderCB()
	if(mSlider.value >= 1) then
		CSAPI.SetGOActive(star, false)
		CSAPI.SetGOActive(success, true)
	end
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
node=nil;
hLayout=nil;
star=nil;
txtStar=nil;
Slider=nil;
success=nil;
txtSuccess=nil;
txtSuccess2=nil;
view=nil;
end
----#End#----