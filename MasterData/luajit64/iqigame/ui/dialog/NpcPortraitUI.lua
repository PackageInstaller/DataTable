-- chunkname: @IQIGame\\UI\\Dialog\\NpcPortraitUI.lua

local DialogPerformanceUtil = require("IQIGame.UI.Dialog.DialogPerformance.DialogPerformanceUtil")
local m = {
	IsCurrent = false,
	LastSoulCid = 0,
	IsFading = false,
	LoadingAsset = false,
	IsLive2D = false,
	NpcCid = 0
}
local Live2DHarmoniousMask = require("IQIGame.UI.Common.Live2DHarmoniousMask")

function m.New(pointGO, viewGO, npcPortraitPool, loadAssetFunc, mainUIRootTrans)
	local obj = Clone(m)

	obj:Init(pointGO, viewGO, npcPortraitPool, loadAssetFunc, mainUIRootTrans)

	return obj
end

function m:Init(pointGO, viewGO, npcPortraitPool, loadAssetFunc, mainUIRootTrans)
	self.View = viewGO
	self.PointGO = pointGO
	self.Canvas = pointGO:GetComponent("Canvas")
	self.NpcPortraitPool = npcPortraitPool
	self.LoadAssetFunc = loadAssetFunc
	self.MainUIRootTrans = mainUIRootTrans
	self.Child = {}

	LuaCodeInterface.BindOutlet(viewGO, self.Child)

	function self.DelegateOnLive2DLoadComplete(sender, args)
		self:OnLive2DLoadComplete(sender, args)
	end

	self.Live2DComponent = self.Child.Live2D:GetComponent("L2DBuilderOptimized")
	self.live2DHarmoniousMask = Live2DHarmoniousMask.New(self.Child.Live2D)

	self.View.transform:SetParent(self.PointGO.transform, false)
	GameEntry.LuaEvent:Subscribe(LoadL2DSuccessEventArgs.EventId, self.DelegateOnLive2DLoadComplete)
end

function m:Show(npcCid, soulActionCid, spineAction, isCurrent)
	self.LoadingAsset = true
	self.LoadingImageOrSpinePath = nil

	local oldNpcCid = self.NpcCid

	self.NpcCid = npcCid
	self.IsCurrent = isCurrent
	self.IsFading = false

	if npcCid ~= oldNpcCid then
		self.View:SetActive(false)

		local timer = ModuleTimerUtil.NewFrameTimer(Constant.UIControllerName.DialogUI, function()
			self:DelayShow(npcCid, soulActionCid, spineAction, oldNpcCid ~= 0)
		end, 1)

		timer:Start()
	else
		self:DelayShow(npcCid, soulActionCid, spineAction, oldNpcCid ~= 0)
	end
end

function m:DelayShow(npcCid, soulActionCid, spineAction, hasOldNpc)
	if hasOldNpc then
		DialogPerformanceUtil.Reset(self.PointGO)
	end

	self.View:SetActive(npcCid ~= 0)

	if npcCid ~= 0 then
		local cfgNpcData = CfgNPCTable[npcCid]

		self.IsLive2D = cfgNpcData.SoulId ~= 0 or cfgNpcData.SoulResId ~= 0

		self.Child.Live2D:SetActive(self.IsLive2D)
		self.Child.Image:SetActive(not self.IsLive2D)

		if cfgNpcData.SoulId ~= 0 then
			local soulData = SoulModule.soulDataDic[cfgNpcData.SoulId]
			local cfgSoulResData

			for i, cfgDressData in pairsCfg(CfgDressTable) do
				if cfgDressData.Type == Constant.DressType.Portrait and cfgDressData.InitialDress ~= 0 and cfgDressData.SoulID == cfgNpcData.SoulId then
					cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]

					break
				end
			end

			self:LoadLive2dBySoulResCID(cfgSoulResData, soulActionCid)
		elseif cfgNpcData.SoulResId ~= 0 then
			self:LoadLive2dBySoulResCID(CfgSoulResTable[cfgNpcData.SoulResId], soulActionCid)
		elseif cfgNpcData.Portrait2D ~= "" then
			local path = UIGlobalApi.GetNpcPortraitPath(cfgNpcData.Portrait2D)

			self:CreateImageOrSpine(path, npcCid, "Portrait2D")
		elseif cfgNpcData.Spine ~= "" then
			local path = UIGlobalApi.GetNpcPortraitPath(cfgNpcData.Spine)

			self:CreateImageOrSpine(path, npcCid, "Spine", spineAction)
		end

		self:UpdateSortingOrder()
	else
		self.IsLive2D = false
	end
end

function m:CreateImageOrSpine(path, npcCid, type, spineAction)
	if path ~= self.CurrentNpcPortraitPath then
		if self.Child.Image.transform.childCount > 0 then
			local currentNpcPortrait = self.Child.Image.transform:GetChild(0).gameObject

			currentNpcPortrait.transform:SetParent(self.MainUIRootTrans, false)
			self.NpcPortraitPool:Release(self.CurrentNpcPortraitPath, currentNpcPortrait)
		end

		local npcPortrait = self.NpcPortraitPool:Obtain(path)

		if npcPortrait ~= nil then
			self:InitImageOrSpine(path, npcPortrait, npcCid, type, spineAction)
		else
			self.LoadingImageOrSpinePath = path

			self.LoadAssetFunc(path, {
				tag = "portrait",
				controller = self,
				npcCid = npcCid,
				subTag = type,
				spineAction = spineAction,
				path = path
			})
		end
	else
		if type == "Spine" and spineAction ~= self.LastSpineAction then
			self:PlaySpineAnimation(spineAction)
		end

		self.LoadingAsset = false
	end
end

function m:InitImageOrSpine(path, npcPortrait, npcCid, type, spineAction)
	self.CurrentNpcPortraitPath = path
	self.LoadingImageOrSpinePath = nil

	local cfgNpcData = CfgNPCTable[npcCid]
	local position = Vector3.zero

	if #cfgNpcData.Position == 2 then
		position.x = cfgNpcData.Position[1]
		position.y = cfgNpcData.Position[2]
	end

	if cfgNpcData.Scale ~= 0 then
		npcPortrait.transform.localScale = Vector3.one * cfgNpcData.Scale
	else
		logError("NPC.Scale不能等于0")
	end

	npcPortrait.transform:SetParent(self.Child.Image.transform, false)

	local initPos = position:Clone()

	initPos.x = 10000
	npcPortrait.transform.anchoredPosition = initPos

	local images = npcPortrait:GetComponentsInChildren(typeof(UnityEngine.UI.Image))

	for i = 0, images.Length - 1 do
		images[i].raycastTarget = false
	end

	if type == "Spine" then
		self:PlaySpineAnimation(spineAction)
	end

	self:UpdateSortingOrder()

	local timer = ModuleTimerUtil.NewFrameTimer(Constant.UIControllerName.DialogUI, function()
		npcPortrait.transform.anchoredPosition = position
	end, 1)

	timer:Start()

	self.LoadingAsset = false
end

function m:PlaySpineAnimation(spineAction)
	if spineAction ~= nil and spineAction ~= "" and spineAction ~= "0" then
		if self.Child.Image.transform.childCount == 0 then
			return
		end

		local npcPortrait = self.Child.Image.transform:GetChild(0).gameObject
		local animation = npcPortrait:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil and animation.state ~= nil then
			local animData = animation.state.Data.SkeletonData:FindAnimation(spineAction)

			if animData ~= nil then
				if animation.AnimationName ~= spineAction or animation.state:GetCurrent(0).IsComplete then
					animation.state:SetEmptyAnimation(0, 0)
					animation.state:SetAnimation(0, spineAction, true)
				end
			else
				logError("对话NPC Spine动作错误：找不到动作：" .. spineAction .. " Npc cid：" .. self.NpcCid)
			end
		end
	end

	self.LastSpineAction = spineAction
end

function m:LoadLive2dBySoulResCID(cfgSoulResData, soulActionCid)
	self.LoadingLive2DPath = UIGlobalApi.Live2DResRootPath .. cfgSoulResData.Live2D

	self.Live2DComponent:Refresh(cfgSoulResData.Id, soulActionCid, Vector3(unpack(cfgSoulResData.Live2DDialogModelPosition)))

	self.LastSoulCid = cfgSoulResData.Id
end

function m:OnLive2DLoadComplete(sender, args)
	if args.AssetName == self.LoadingLive2DPath then
		self.LoadingLive2DPath = nil
		self.LoadingAsset = false
	end
end

function m:OnLoadSucceed(assetName, asset, duration, userData)
	if self.View == nil then
		return
	end

	self.NpcPortraitPool:Register(assetName, asset)

	if userData.path == self.LoadingImageOrSpinePath then
		local npcPortrait = self.NpcPortraitPool:Obtain(assetName)

		self:InitImageOrSpine(assetName, npcPortrait, userData.npcCid, userData.subTag, userData.spineAction)
	end
end

function m:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function m:SetCanvasOrder(sortingOrder)
	self.MainUICanvasSortingOrder = sortingOrder

	self:UpdateSortingOrder()
end

function m:UpdateSortingOrder()
	if self.MainUICanvasSortingOrder == nil or self.MainUICanvasSortingOrder == 0 then
		return
	end

	self.Canvas.enabled = false

	if self.NpcCid ~= 0 then
		local addOrder

		addOrder = self.IsFading and 3 or self.IsCurrent and 2 or 1

		local renderers = self.Child.Image:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		if not self.IsLive2D and renderers.Length > 0 then
			self.Canvas.enabled = false

			for i = 0, renderers.Length - 1 do
				renderers[i].sortingOrder = self.MainUICanvasSortingOrder + addOrder
			end
		else
			self.Canvas.enabled = true
			self.Canvas.sortingOrder = self.MainUICanvasSortingOrder + addOrder
		end
	end
end

function m:Dispose()
	GameEntry.LuaEvent:Unsubscribe(LoadL2DSuccessEventArgs.EventId, self.DelegateOnLive2DLoadComplete)

	if self.Child.Image.transform.childCount > 0 then
		local currentNpcPortrait = self.Child.Image.transform:GetChild(0).gameObject

		if currentNpcPortrait ~= nil then
			self.NpcPortraitPool:Release(self.CurrentNpcPortraitPath, currentNpcPortrait)
		end
	end

	self.live2DHarmoniousMask:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self.Child)

	self.View = nil
	self.Child = nil
	self.NpcPortraitPool = nil
	self.LoadAssetFunc = nil
	self.MainUIRootTrans = nil
end

return m
