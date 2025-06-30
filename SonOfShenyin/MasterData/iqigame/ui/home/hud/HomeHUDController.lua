-- chunkname: @IQIGame\\UI\\Home\\HUD\\HomeHUDController.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local HomeActorHUD = require("IQIGame/UI/Home/HUD/HomeActorHUD")
local HomeHUDController = {
	workActorHUDItems = {}
}

function HomeHUDController.New(view)
	local obj = Clone(HomeHUDController)

	obj:__Init(view)

	return obj
end

function HomeHUDController:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.workHUD.gameObject:SetActive(false)

	self.workHUDItemPool = UIViewObjectPool.New(self.workHUD, nil, function(_view)
		return HomeActorHUD.New(_view)
	end)
end

function HomeHUDController:Show()
	self.gameObject:SetActive(true)
end

function HomeHUDController:Hide()
	self.gameObject:SetActive(false)
end

function HomeHUDController:OnFrameUpdate()
	ForPairs(self.workActorHUDItems, function(_actorCid, _speakItem)
		_speakItem:OnFrameUpdate()
	end)
end

function HomeHUDController:Dispose()
	self.workActorHUDItems = nil

	self.workHUDItemPool:Dispose(function(_item)
		_item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function HomeHUDController:AddWorkActor(actorCid, uiMountTrans)
	if self.workActorHUDItems[actorCid] ~= nil then
		logError("家园打工角色重复添加")

		return
	end

	local hudItem = self.workHUDItemPool:GetFree(function(_item)
		return _item:IsFree()
	end)

	hudItem:Mount(actorCid, uiMountTrans)

	self.workActorHUDItems[actorCid] = hudItem
end

function HomeHUDController:RemoveWorkActor(actorCid)
	local hudItem = self.workActorHUDItems[actorCid]

	if hudItem == nil then
		return
	end

	hudItem:Release()

	self.workActorHUDItems[actorCid] = nil
end

function HomeHUDController:ShowWorkActorSpeak(actorCid, speakCid)
	local hudItem = self.workActorHUDItems[actorCid]

	if hudItem == nil then
		logError("工作单位 {0} 找不到说话组件", actorCid)

		return
	end

	hudItem:ShowSpeak(speakCid)
end

return HomeHUDController
