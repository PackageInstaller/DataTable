-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetskinposterView.lua

module("logic.extensions.petskin.view.PetskinposterView", package.seeall)

local PetskinposterView = class("PetskinposterView", ViewComponent)

function PetskinposterView:ctor()
	PetskinposterView.super.ctor(self)
end

function PetskinposterView:buildUI()
	PetskinposterView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.posterGo = self:getGo("poster/con")
	self._posterImage = self:getGo("poster/spineImage")
	self.txtState = self:getTxt("waikuang/txtState")
	self._petPhotoShow = PetPhotoShow.Get(self._posterImage)

	self._petPhotoShow:setCallBackOnEffLoadedAfter(GameUtil.handler(self._onReloadSpineInterfaceCompOfSkeletonAnimation, self))
	self._petPhotoShow:setCallBackOnEffUnloadBefore(GameUtil.handler(self._onUnReloadSpineInterfaceCompOfSkeletonAnimation, self))

	self._spineInterface = self:getGo("poster/spineInterface")
	self._spineComp = SpineInterfaceComp.getOrAdd(self._spineComp, self._spineInterface)
	self._btn_left = self:getGo("btn_left")
	self._btn_right = self:getGo("btn_right")
	self._btnUse = self:getGo("btnUse")
	self._mark = self:getGo("btnUse/mark")
	self.cell = self:getGo("cell")
	self.ScrollView = self:getGo("tableview")
	self._btnUpDyn = self:getGo("btnUpDyn")
	self._txtUpDyn = self:getTxt("btnUpDyn/txt")
	self._tableview = ScrollerList.create(self.ScrollView, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	local capacity = 20

	local function createFunc()
		return UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
	end

	local function disposeFunc(obj)
		UnityEngine.GameObject.Destroy(obj)
	end

	local function resetFunc(obj)
		obj.mainTexture = nil
	end

	self._objectPool = ObjectPool.New(capacity, createFunc, disposeFunc, resetFunc)
	self._usedMatList = {}
end

function PetskinposterView:destroyUI()
	PetskinposterView.super.destroyUI(self)
	self._objectPool:clear()
end

function PetskinposterView:bindEvents()
	PetskinposterView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self._btn_left, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btn_right, self._onClickRight, self)
	GameUtil.addClickHandler(self._btnUse, self._onClickUse, self)
	GameUtil.addClickHandler(self._btnUpDyn, self._onClickUpDyn, self)
end

function PetskinposterView:unbindEvents()
	PetskinposterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self._btn_left)
	GameUtil.rmClickHandler(self._btn_right)
	GameUtil.rmClickHandler(self._btnUse)
	GameUtil.rmClickHandler(self._btnUpDyn)
end

function PetskinposterView:onEnter()
	PetskinposterView.super.onEnter(self)
	self:_returnMats()

	local params = self:getOpenParam() or {}

	if not params[1] then
		local posterId = 0

		self._postIdList = params[2] or {}
		self._fromSkinId = checknumber(params[3])
		self._curIndex = 1

		for i, v in ipairs(self._postIdList) do
			if v == posterId then
				self._curIndex = i
			end
		end

		GameUtil.SetActive(self._btn_left, #self._postIdList > 1)
		GameUtil.SetActive(self._btn_right, #self._postIdList > 1)
		GameUtil.SetActive(self._btnUse, self._fromSkinId > 0)
		GameUtil.SetActive(self._btnUpDyn, self._fromSkinId > 0)
		self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._refreshUI, self)
		self:_updateMark()
		self:_updateCurrPoster(posterId)
	end
end

function PetskinposterView:onEnterFinished()
	PetskinposterView.super.onEnterFinished(self)
end

function PetskinposterView:onExit()
	PetskinposterView.super.onExit(self)
	self:_unLoadSpineBySkeletonAnimation()
	self._tableview:dispose()
	self:_returnMats()

	if self._spineComp then
		self._spineComp:unload()
	end
end

function PetskinposterView:_refreshUI()
	self:_updateMark()
	self:_updateCurrPoster(self._posterId)
end

function PetskinposterView:_onClickUse()
	if self._posterId > 0 and self._fromSkinId > 0 then
		PetskinController.instance:saveSkinPosterId(self._fromSkinId, self._posterId)
		self:_updateMark()
		GameUtil.SetActive(self._mark, self._curSkinPosterId == self._posterId)
	end
end

function PetskinposterView:_onClickUpDyn()
	if self._posterId > 0 then
		local boo = PetskinModel.instance:getIsUnlockDyPoster(self._posterId)

		if boo then
			return
		end

		local cfg = PetSkinConfig.instance:getPosterModelCo(self._posterId)

		if cfg then
			if PetskinController.instance:getPosterActive(cfg) then
				local unlockDynamicEffectsCost = cfg.unlockDynamicEffectsCost

				PayShopController.instance:buyShopItemWithTips(unlockDynamicEffectsCost)
			else
				TipsFacade.instance:openCommonTips("暂未获得此皮肤，无法升级动态海报")
			end
		end
	end
end

function PetskinposterView:_onClickLeft()
	self._curIndex = self._curIndex - 1

	if self._curIndex == 0 then
		self._curIndex = #self._postIdList
	end

	local posterId = self._postIdList[self._curIndex]

	self:_updateCurrPoster(posterId)
end

function PetskinposterView:_onClickRight()
	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._postIdList then
		self._curIndex = 1
	end

	local posterId = self._postIdList[self._curIndex]

	self:_updateCurrPoster(posterId)
end

function PetskinposterView:_updateMark()
	self._curSkinPosterId = -1

	if self._fromSkinId > 0 then
		local cfg = PetskinController.instance:getPosterCfg(self._fromSkinId)

		if cfg then
			self._curSkinPosterId = cfg.posterId
		end
	end
end

function PetskinposterView:_updateCurrPoster(posterId)
	self._posterId = checknumber(posterId)

	GameUtil.SetActive(self._btnUse, false)

	if self._posterId <= 0 then
		self:_unLoadSpineBySkeletonAnimation()

		return
	end

	self:_loadSpineBySkeletonAnimation(self._posterId)

	local cfg = PetSkinConfig.instance:getPosterModelCo(self._posterId)
	local isHas = PetskinController.instance:getPosterActive(cfg)

	GameUtil.SetActive(self._btnUse, isHas and self._fromSkinId > 0)

	self._txtUpDyn.text = "升级动态"

	GameUtil.SetActive(self._btnUpDyn, not string.nilorempty(cfg.resNameExt) and self._fromSkinId > 0)

	local boo = PetskinModel.instance:getIsUnlockDyPoster(self._posterId)

	if boo then
		self._txtUpDyn.text = "已升级动态"
	end

	GameUtil.SetGray(self._btnUpDyn, boo)
	GameUtil.SetActive(self._mark, self._curSkinPosterId == self._posterId)

	self.txtState.text = isHas and lang("已解锁") or lang("未解锁")

	local unlockItems = {}

	for i, v in ipairs(cfg.skinId) do
		local item = {
			type = "skin",
			value = v
		}

		table.insert(unlockItems, item)
	end

	if not string.nilorempty(cfg.unlockItems) then
		local items = string.split(cfg.unlockItems, "#")

		for i, v in ipairs(items) do
			local item = {
				type = "item",
				value = v
			}

			table.insert(unlockItems, item)
		end
	end

	self._tableview:reloadData(unlockItems)
end

function PetskinposterView:_loadSpineBySkeletonAnimation(skinId)
	self._petPhotoShow:showPetPoster(skinId, true)
end

function PetskinposterView:_unLoadSpineBySkeletonAnimation()
	self:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()

	if self._petPhotoShow then
		self._petPhotoShow:clear()
	end
end

function PetskinposterView:_onReloadSpineInterfaceCompOfSkeletonAnimation(photoShow)
	self._spineComp = SpineInterfaceComp.reloadPhotoShow(self._spineComp, self._spineInterface, photoShow, true)
end

function PetskinposterView:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()
	if self._spineComp then
		self._spineComp:unload()
	end
end

function PetskinposterView:_updateCell(view, cell, data, tag)
	local container = goutil.findChild(cell, "container")
	local imgState = goutil.findChild(cell, "imgState")
	local btnGoto = goutil.findChild(cell, "btnGoto")

	GameUtil.rmClickHandler(cell)
	GameUtil.SetActive(imgState, false)
	GameUtil.SetActive(btnGoto, false)

	if data.type == "skin" then
		local skinId = data.value

		MaterialMgr.setCell(MatType.PET_SKIN, skinId, container)

		local isHas = PetskinController.instance:checkHasForeverSkinBySkinId(skinId)

		if isHas then
			-- block empty
		else
			GameUtil.SetActive(btnGoto, true)
			GameUtil.addClickHandler(cell, GameUtil.handler(self.goSource, self, MatType.PET_SKIN, skinId))
		end
	elseif data.type == "item" then
		local cfgStr = data.value

		MaterialMgr.setCellByCfg(cfgStr, container)

		local matType, matId, matNum = MaterialMgr.getMatParams(cfgStr)
		local isHas = matNum <= checknumber(MaterialModel.instance:getMaterialsNumber(matType, matId))

		if isHas then
			GameUtil.SetActive(imgState, true)
		else
			GameUtil.SetActive(btnGoto, true)
			GameUtil.addClickHandler(cell, GameUtil.handler(self.goSource, self, matType, matId))
		end
	end
end

function PetskinposterView:clearCell(cell)
	local container = goutil.findChild(cell, "container")

	MaterialMgr.resetAll(container)
end

function PetskinposterView:goSource(matType, matId)
	MaterialMgr.openGetSource(matType, matId)
end

function PetskinposterView:_returnMats()
	if #self._usedMatList > 0 then
		for i, v in ipairs(self._usedMatList) do
			self._objectPool:returnObject(v)
		end

		table.clear(self._usedMatList)
	end
end

return PetskinposterView
