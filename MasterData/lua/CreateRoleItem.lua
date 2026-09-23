
function Awake()
	CSAPI.SetGOActive(img6, false)
	CSAPI.SetGOActive(img7, false)
	CSAPI.AddEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot,ShareView_NoticeTheNextFrameScreenshot)
	CSAPI.AddEventListener(EventType.ShareView_NoticeScreenshotCompleted,ShareView_NoticeScreenshotCompleted)
end

function SetIndex(_index)
	index = _index
	local angle = index > 5 and 180 or 0
	CSAPI.SetRectAngle(node, 0, 0, angle)
end

--item获得的物品
function Refresh(data, goodsData)
	cfg = Cfgs.CardData:GetByID(data.id)
	--all img
	SetImgs()
	--icon
	SetIcon()
	--new
	CSAPI.SetGOActive(new, data.isNew)
	--粒子
	--SetPariticle()
	--碎片
	CSAPI.SetGOActive(itemParent, goodsData and #goodsData > 0 and (not data.isNew) and true or false)
	if(goodsData) then
		for i, v in ipairs(goodsData) do
			local go = ResUtil:CreateUIGO("Grid/CreateGridItem", iconBg.transform)
			CSAPI.SetScale(go, 0.7, 0.7, 1)
			local item = ComUtil.GetLuaTable(go)
			local goodsData, clickCB = GridFakeData(v)
			item.Refresh(goodsData)
			item.SetCount(v.num)
			-- local tab = ResUtil:CreateRandRewardGrid(v, itemParent.transform)
			-- tab.SetClickCB(nil)
		end
	end
end

function SetImgs()
	local q = cfg.quality or 3
	--img1-6
	for i = 1, 6 do
		local index = i == 6 and 5 or i
		if(index ~= 4) then	
			local imgName = string.format("UIs/CreateShow/img_%s_0%s.png", 5 - q + 8, index)
			CSAPI.LoadImg(this["img" .. i], imgName, true, nil, true)
		end
	end
	--grid
	local teamCfg = Cfgs.CfgTeamEnum:GetByID(cfg.nClass)
	local teamIcon = "bg_blue"
	if(q > 3) then
		teamIcon = q == 4 and "bg_purple" or "bg_yellow"
	end
	ResUtil:LoadBigImg(grid, "UIs/Create/" .. teamCfg.cIcon .. "/" .. teamIcon, true)
	-- local gridName = string.format("UIs/CreateShow/img_13_0%s.png", 5 - q + 1)
	-- CSAPI.LoadImg(grid, gridName, true, nil, true)
	--star
	-- local starName = string.format("UIs/CreateShow/img_12_0%s.png", 5 - q + 1)
	-- CSAPI.LoadImg(star, starName, true, nil, true)

	ResUtil.RoleCard_BG:Load(imgStar, "img_01_0" .. q)
end

function SetIcon()
	local cfgModel = Cfgs.character:GetByID(cfg.model)
	if(cfgModel.Card_head) then
		ResUtil.CardIcon:Load(icon, cfgModel.Card_head)
	end
end

-- function SetPariticle()
-- 	if(cfg.quality > 3) then
-- 		ResUtil:CreateEffect("OpenBox/CardEffect_Gold", 0, 0, 0, pariticle)
-- 	end
-- end
function SetEffect()
	--CSAPI.SetGOActive(img4, true)
	local effectName = "CardEffect_Blue"
	if(cfg.quality > 3) then
		if(cfg.quality == 6) then
			effectName = "CardEffect_Color"
		else
			effectName = cfg.quality == 4 and "CardEffect_Purple" or "CardEffect_Gold"
		end
	end
	ResUtil:CreateEffect("OpenBox/" .. effectName, 0, 0, 0, pariticle, function(go)
		if(index > 5) then
			CSAPI.SetScale(go, 1, - 1, 1)
		end
	end)
end

function SetImg67Anim(timer, delay)
	--img6
	local wh6 = ComUtil.GetCom(img5, "ActionBase")
	wh6.delay = delay
	wh6.time = timer
	CSAPI.SetGOActive(img5, true)
	--img7
	local wh7 = ComUtil.GetCom(img6, "ActionBase")
	wh7.delay = delay
	wh7.time = timer
	CSAPI.SetGOActive(img6, true)
end

---截图前一帧通知
function ShareView_NoticeTheNextFrameScreenshot(Data)
	CSAPI.SetGOActive(itemParent, false);
end
---截图完成通知
function ShareView_NoticeScreenshotCompleted(Data)
	CSAPI.SetGOActive(itemParent, true);
end
function OnDestroy()
	CSAPI.RemoveEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot,ShareView_NoticeTheNextFrameScreenshot)
	CSAPI.RemoveEventListener(EventType.ShareView_NoticeScreenshotCompleted,ShareView_NoticeScreenshotCompleted)

end