local lua = nil;
local fade = nil
local move = nil

function Awake()
	-- local go = ResUtil:CreateUIGO("Grid/GridItem", gridNode.transform);
	--CSAPI.SetScale(go, 0.85, 0.85, 1)
	-- lua = ComUtil.GetLuaTable(go);
	local go,l=ResUtil:CreateRewardGrid(gridNode.transform);
	lua=l;
	fade = ComUtil.GetCom(gameObject, "ActionFade")
	move = ComUtil.GetCom(node, "ActionMoveByCurve")

	CSAPI.SetGOActive(specImg, false)
end

function SetIndex(idx)
	index = idx
end

function Refresh(data, elseData)
	if lua and data then
		SetFindImg(false)
		this.data = data;
		--持有数设置
		local reward = data.data or {}
		local count = 0 --可以获取的奖励数量
		if reward.id then
			count = reward.num or 0
			-- reward.num = BagMgr:GetCount(reward.id)
		else
			-- reward = {id = data.cfg.id, num = BagMgr:GetCount(data.cfg.id)}
			reward = {id = data.cfg.id}
		end
		data.data = reward
		
		lua.Refresh(data, {isClick = true});
		lua.SetLimitTag(false)
		local type = data.cfg.type
		local _cb = type ~= nil and GridClickFunc.OpenInfoShort or GridClickFunc.EquipDetails
		lua.SetClickCB(_cb);
		lua.RegisterCB();
		CSAPI.SetGOActive(tipsObj, elseData ~= nil)		
		if elseData then
			local tips = elseData.tag == nil and "" or RewardUtil.GetTips(elseData.tag);
			CSAPI.SetText(txt_tips, tips);
			CSAPI.SetGOActive(tick, elseData.isPass)
			if elseData.tag then
				local iconName = "img_02_01"
				local code = "ffffff"
				if elseData.tag == ITEM_TAG.FirstPass or elseData.tag == ITEM_TAG.ThreeStar then
					iconName = elseData.isPass and "img_02_03" or "img_02_02"
				elseif elseData.tag == ITEM_TAG.TimeLimit then
					iconName = "img_02_04"
				elseif elseData.tag == ITEM_TAG.Other then
					iconName = "img_02_05"
					code = "00ffbf"
				end
				CSAPI.LoadImg(tipImg,"UIs/DungeonDetail/" .. iconName .. ".png",true,nil,true)
				CSAPI.SetImgColorByCode(tipImg,code)
			else
				CSAPI.LoadImg(tipImg,"UIs/DungeonDetail/img_02_02.png",true,nil,true)
			end
			if not canvasGroup then
				canvasGroup = ComUtil.GetCom(gridNode, "CanvasGroup")
			end	
			canvasGroup.alpha = elseData.isPass and 0.7 or 1
			CSAPI.SetGOActive(tipImg,tips ~= "")
		end
		-- lua.SetChoosieIcon(true);
		local numStr = ""
		if count > 0 then --通关奖励获得的数量
			numStr = "X" .. count
		end
		lua.SetCount(numStr)
		-- lua.SetCountText(numStr);
	end
end

function SetChoosie(isChoosie)
	if lua then
		--lua.SetChoosie(isChoosie);
	end
end

function SetFindImg(isShow)
	CSAPI.SetScale(findImg, 1, 1, 1)
	CSAPI.SetGOActive(findImg, isShow)
end

function SetClickCB(cb)
	if lua then
		--lua.SetClickCB(cb);
	end
end

function SetSpecial(b,iconName)
	if iconName and iconName~="" then
		CSAPI.LoadImg(specImg,"UIs/DungeonDetail/"..iconName..".png",true,nil,true)
	end
	CSAPI.SetGOActive(specImg, b)
end

function PlayFade(idx)
	fade:Play(0, 1, 250, 100 * idx)
end

function SetTween(delay)
	delay = delay or 0
	local idx = math.floor(index / 8) < 1 and(index - 1) or(index % 8)
	fade:Play(0, 1, 250, 200 + 50 * idx + delay)
	move.delay = 200 + 50 * idx + delay
	move:Play()
end

function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	gridNode = nil;
	tipsObj = nil;
	tick = nil;
	txt_tips = nil;
	view = nil;
end
----#End#----
