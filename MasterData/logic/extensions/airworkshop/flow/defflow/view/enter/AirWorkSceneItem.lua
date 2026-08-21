-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/enter/AirWorkSceneItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.enter.AirWorkSceneItem", package.seeall)

local M = class("AirWorkSceneItem")

function M:ctor(container)
	self.mainGO = container.gameObject
	self._goLock = goutil.findChild(self.mainGO, "btnClick/stateLock")
	self._lockTxt = goutil.findChildTextComponent(self.mainGO, "btnClick/stateLock/txtContent")
	self._contentTxt = goutil.findChildTextComponent(self.mainGO, "btnClick/txtName")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "btnClick/mask/imgTheme")
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self.mainGO, "btnClick"))
	self._txtHero = goutil.findChildTextComponent(self.mainGO, "btnClick/imgPeopleNumber/txt2/txtPeopleNumber")
	self._txtHighland = goutil.findChildTextComponent(self.mainGO, "btnClick/imgNormalBulid/txt2/txtNormalBulid")
	self._txtBuilding = goutil.findChildTextComponent(self.mainGO, "btnClick/imgSpecialBulid/txt2/txtSpecialBulid")
	self._txtMessage = goutil.findChildTextComponent(self.mainGO, "btnClick/imgMessage/txt2/txtMessage")
	self._newSignGo = goutil.findChild(self.mainGO, "btnClick/new_sigh")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:setSceneCO(sceneCO, idx)
	self._sceneCO = sceneCO
	self._idx = idx

	self:_updateView()
end

function M:_updateView()
	local unLock = AirWorkShopModel.instance:getIsSceneOrBuildingUnlockById(GameEnum.UnlockTypeEnum.Scene, self._sceneCO.id)

	goutil.setActive(self._goLock, not unLock)

	if not unLock then
		self._lockTxt.text = lang("tip_airwork_unlocked")
	end

	self._contentTxt.text = self._sceneCO.name

	IconLoader.setSprite(self._imgIcon, IconType.AirWorkShopTheme, self._sceneCO.icon)

	local sceneCO = self._sceneCO

	self._txtHero.text = sceneCO.entityLimit
	self._txtHighland.text = sceneCO.highBuildingLimit
	self._txtBuilding.text = sceneCO.effectBuildingLimit
	self._txtMessage.text = sceneCO.messageBuildingLimit

	local isNew = false
	local itemDatas = ItemModel.instance:getItemsByItemId(self._sceneCO.id)

	if #itemDatas > 0 then
		isNew = itemDatas[1]:getRedPointIsNew()
	end

	goutil.setActive(self._newSignGo, unLock and isNew)
end

function M:setSeleted(isSelect)
	return
end

function M:setClickCallBack(func, handler)
	self._clickFunc = func
	self._clickHandler = handler
end

function M:_onClick()
	local itemDatas = ItemModel.instance:getItemsByItemId(self._sceneCO.id)

	if #itemDatas > 0 then
		local isNew = itemDatas[1]:getRedPointIsNew()

		if isNew then
			local itemid = itemDatas[1]:getUuid()
			local type = GameEnum.ItemTypeEnum.AirScene

			BackpackAgent.instance:sendremoveRedPointRequest(type, {
				itemid
			})
		end
	end

	if self._clickFunc then
		self._clickFunc(self._clickHandler, self._idx)
	end
end

return M
