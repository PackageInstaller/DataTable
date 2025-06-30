-- chunkname: @IQIGame\\UI\\Home\\UIActorController\\UIPaintingController.lua

local UIButtonActorController = require("IQIGame/UI/Home/UIActorController/UIButtonActorController")
local Controller = Clone(UIButtonActorController)

function Controller:__OnInit()
	self:__OnButtonActor_OnInit()

	self.paintingTable = {}

	self:__RefreshShow()
end

function Controller:__RefreshShow()
	local selectCid = PlayerModule.GetUsingPaintingItemCid()

	self:__RefreshPaintingShow(selectCid)
end

function Controller:__RefreshPaintingShow(itemCid)
	ForPairs(self.paintingTable, function(_itemCid, _paintingGo)
		local active = _itemCid == itemCid

		_paintingGo.gameObject:SetActive(active)
	end)

	if self.paintingTable[itemCid] == nil then
		self:__LoadPaintingGameObject(itemCid)
	end
end

function Controller:__LoadPaintingGameObject(itemCid)
	local cfgPainting = CfgUIPaintingItemTable[itemCid]

	AssetUtil.LoadAsset(self, cfgPainting.PrefabPath, function(_, _, asset, _, userData)
		self:__OnPaintingItemLoaded(asset, userData)
	end, function()
		logError("挂画加载失败PaintingItemCid: {1}", itemCid)
	end, {
		paintingItemCid = itemCid
	})
end

function Controller:__OnPaintingItemLoaded(asset, userData)
	if self.paintingTable == nil then
		return
	end

	if self.paintingTable[userData.paintingItemCid] ~= nil then
		return
	end

	local obj = UnityEngine.Object.Instantiate(asset)

	obj.gameObject.transform:SetParent(self.view.ContentRoot.transform, false)

	obj.gameObject.transform.localScale = Vector3.one
	obj.gameObject.transform.localPosition = Vector3.zero

	local selectCid = PlayerModule.GetUsingPaintingItemCid()
	local active = selectCid == userData.paintingItemCid

	obj.gameObject:SetActive(active)

	self.paintingTable[userData.paintingItemCid] = obj
end

function Controller:__OnAddListeners()
	self.view.triggerBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnTriggerBtnClick)
	EventUtil.AddEventListener(self, EventID.OnSaveDataSuccess, self.__OnSavePlayerDataSuccess)
end

function Controller:__OnRemoveListeners()
	self.view.triggerBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnTriggerBtnClick)
	EventUtil.ClearEventListener(self)
end

function Controller:__OnTriggerBtnClick()
	UIModule.Open(Constant.UIControllerName.UIPaintingThemeUI, Constant.UILayer.UI)
end

function Controller:__RefreshUnlockBtn()
	return
end

function Controller:__OnSavePlayerDataSuccess()
	self:__RefreshShow()
end

function Controller:__OnDispose()
	ForPairs(self.paintingTable, function(_, _go)
		GameObject.Destroy(_go)
	end)

	self.paintingTable = nil

	self:__RemoveRedDot()
	self:__RemoveUnlockFunc()
	LuaCodeInterface.ClearOutlet(self.actor.gameObject, self.view)
end

return Controller
