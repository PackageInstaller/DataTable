--开箱界面
--1抽位置
local effetPos1 = {0, 124, 0}
--10抽位置
local effectPos10 = {
	{- 188.9, 237.5, 0},
	{6.7, 232.3, 0},
	{205.6, 229.6, 0},
	{- 291, 86.9, 0},
	{- 91, 82.4, 0},
	{101.4, 81.2, 0},
	{300.7, 78.5, 0},
	{- 199.1, - 60.7, 0},
	{3, - 60.58, 0},
	{204.6, - 66.7, 0},
}


function Awake()
	CSAPI.SetGOActive(uis, false)
	CSAPI.SetGOActive(objAnim2, false)
end

function Refresh(_cardDatas, _cb)
	cardDatas = _cardDatas
	cb = _cb
	
	is10 = #cardDatas > 1
	
	ShowOpenBoxAni()
	
	SetClick()
end

--click适配
function SetClick()
	local arr = CSAPI.GetMainCanvasSize()
	local h2 = arr[1]
	local scale = h2 / 1080
	CSAPI.SetAnchor(click, - 2, - 201 * scale, 0)
	CSAPI.SetScale(click, scale, scale, 1)
end

function ShowOpenBoxAni()
	if(is10) then
		boxAni = ResUtil:PlayVideo("create_10", MVParent)
	else
		boxAni = ResUtil:PlayVideo("create_1", MVParent)
	end		
	boxAni:AddFrameEvent(90, SetAnim1)
	boxAni:AddFrameEvent(120, WaitClickBox) --此时被暂停
	boxAni:AddFrameEvent(135, OpenBoxSound)
	boxAni:AddFrameEvent(165, EffectSound)
	boxAni:AddFrameEvent(180, AniComplete)
	--boxAni:AddCompleteEvent(AniComplete) --太慢
	CSAPI.PlayUICardSound("ui_card_draw_opendoor")	--显示盒子
end

function SetAnim1()
	CSAPI.SetGOActive(uis, true)
end

function SetAnim2()
	CSAPI.SetGOActive(objAnim, false)
	local aim = ComUtil.GetCom(clickAnim, "ActionBase")
	aim:ToPlay(function()
		CSAPI.SetGOActive(click, false)
	end)
end

--自动触发点击盒子
function WaitClickBox()
	if(not boxAni) then
		return
	end
	isCanClickBox = true
	boxAni:Pause(true)
	EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "guide_trigger_flag");--自定义引导触发标记	
end

function OpenBoxSound()
	if(not boxAni) then
		return
	end
	if(is10) then
		CSAPI.PlayUICardSound("ui_card_draw_openbox")  --开盒
	else
		CSAPI.PlayUICardSound("ui_card_draw_openbox_2")  --开盒
	end
end

function EffectSound()
	if(not boxAni) then
		return
	end
	CSAPI.PlayUICardSound("ui_card_draw_core_out")  --特效出现音效
end

--开箱完成
function AniComplete()
	if(not boxAni) then
		return
	end
	EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "guide_trigger_flag");--自定义引导触发标记
	
	--生成特效
	effectItems = {}
	clickCache = {}
	for i, v in ipairs(cardDatas) do
		clickCache[i] = 1
		ResUtil:CreateUIGOAsync("CreateShow/CreateEffect", boxAni.gameObject, function(go)
			local tab = ComUtil.GetLuaTable(go)
			local quality = v:GetQuality()
			local pos = is10 and effectPos10[i] or effetPos1
			tab.SetClickCB(EffectClickCB)
			tab.Refresh(i, quality, pos, is10)
			table.insert(effectItems, tab)
		end)
	end
end

--点击卡槽
function EffectClickCB(index)
	clickCache[index] = 0
	--全部点击，开始展示卡牌
	CheckIsClickAll()
	
	if(CheckIsClickAll()) then	
		FuncUtil:Call(PlayWaitEffect, nil, 1000)
		FuncUtil:Call(StartShow, nil, 1900)
	end
end

--是否已全部点击
function CheckIsClickAll()
	for i, v in ipairs(clickCache) do
		if(v == 1) then
			return false
		end
	end
	return true
end

--白屏特效 
function PlayWaitEffect()
	if(not boxAni) then
		return
	end
	ResUtil:CreateEffect("OpenBox/OpenBoxWhiteScreen", 0, 0, 0, MVParent, function(go)
		FuncUtil:Call(HideEffects, nil, 500)
		FuncUtil:Call(function()
			CSAPI.RemoveGO(gameObject) --移除界面
		end, nil, 1000)
		
		CSAPI.PlayUICardSound("ui_card_draw_transition") --白屏音效
	end)
end

--隐藏卡牌特效
function HideEffects()
	if(not effectItems) then
		return
	end
	for i, v in ipairs(effectItems) do
		CSAPI.SetGOActive(v.gameObject, false)
	end
end

function RemoveAni()
	if(not boxAni) then
		return
	end
	boxAni:Pause(true)
	boxAni = nil
	effectItems = nil
end

function StartShow(isSkip)
	if(boxAni) then
		RemoveAni()
		--CSAPI.StopUICardSound("ui_card_draw_ambience")
		cb(isSkip)
	end
end

--点击背景 	继续开箱动画
function OnClickBg()
	if(boxAni and isCanClickBox) then
		SetAnim2()
		isCanClickBox = false
		boxAni:Pause(false)
		
		CSAPI.PlayUICardSound("ui_card_draw_open_clik")	--点击盒子
	end
end

--跳过
function OnClickSkip()
	StartShow(true)
	CSAPI.RemoveGO(gameObject) --移除界面
end

function SetSkipState(state)
	CSAPI.SetGOActive(btnSkip, state);
end 

function OnDestroy()    
	CSAPI.StopUICardSound("ui_card_draw_ambience")
end

