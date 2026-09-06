-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainBtnExpandView.lua

module("logic.extensions.mainui.view.MainBtnExpandView", package.seeall)

local MainBtnExpandView = class("MainBtnExpandView", ViewComponent)

function MainBtnExpandView:buildUI()
	self._btnsTran = self:getGo("content/btnsTranGo").transform
	self._btnGo = self:getGo("content/btnGo")
	self._content = self:getGo("content")
	self._customInput = UICustomInput.Get(self._content)
	self._btnClose = self:getGo("content/btnClose")

	GameUtil.SetActive(self._btnsTran.gameObject, false)
	GameUtil.SetActive(self._btnGo, false)
end

function MainBtnExpandView:bindEvents()
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function MainBtnExpandView:unbindEvents()
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnClose)
end

function MainBtnExpandView:_onCustomInputCallback(hover)
	if GuideModel.instance:isGuiding() then
		return
	end

	if not hover then
		self:close()
	end
end

function MainBtnExpandView:_onClickClose()
	if GuideModel.instance:isGuiding() then
		return
	end

	self:close()
end

function MainBtnExpandView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.UpdateMainUIFuncs, self._updateFuncOpenAndRedpoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnNewFunctionOpen, self._updateFuncOpenAndRedpoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateAllRedpoint, self)

	self._isShowExpand = false

	self:_onClickViewBtn()
	MainUIController.instance:setExpandBtnsList(nil)
end

function MainBtnExpandView:destroyUI()
	for _, item in pairs(self._btnItemList or {}) do
		if item then
			UnityEngine.GameObject.Destroy(item)
		end
	end

	self._btnItemList = nil
	self._funcInfoList = nil
end

function MainBtnExpandView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.UpdateMainUIFuncs, self._updateFuncOpenAndRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.OnNewFunctionOpen, self._updateFuncOpenAndRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateAllRedpoint, self)

	local parms = self:getFirstParam()

	self:_updateShowExpandBtns(parms)
end

function MainBtnExpandView:_updateShowExpandBtns(parms)
	self._isShowExpand = false
	self._btnItemList = self._btnItemList or {}

	for _, item in pairs(self._funcInfoList or {}) do
		if item and item.cellGo then
			GameUtil.asBtn(item.cellGo):RemoveClickListener()
		end
	end

	self._curParams = parms

	if parms == nil or parms.localPos == nil or parms.sonFuncIds == nil then
		GameUtil.SetActive(self._clickGo, false)
		GameUtil.SetActive(self._btnsTran.gameObject, false)

		return
	end

	self._isShowExpand = true

	self:_updateFuncOpenAndRedpoint()
end

function MainBtnExpandView:_updateFuncOpenAndRedpoint()
	self._funcInfoList = self._funcInfoList or {}

	if self._curParams == nil or self._curParams.localPos == nil or self._curParams.sonFuncIds == nil then
		self._isShowExpand = false

		return
	end

	if not self._isShowExpand then
		return
	end

	GameUtil.SetActive(self._clickGo, true)
	GameUtil.SetActive(self._btnsTran.gameObject, true)

	local funcId, go, cfg, isHide
	local index = 0

	for i = 1, #self._curParams.sonFuncIds do
		funcId = checknumber(self._curParams.sonFuncIds[i])
		cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

		if cfg and not MainUIController.instance:getHudVisible(funcId) then
			local isOpen = FuncOpenModel.instance:getFuncIsOpen(funcId)

			if cfg.form == 1 or isOpen then
				index = index + 1
				go = self._btnItemList[index] and self._btnItemList[index] or goutil.cloneAndSetParent(self._btnGo, self._btnsTran, "btn_" .. funcId)

				GameUtil.SetActive(go, true)

				self._btnItemList[index] = go

				if self._funcInfoList[funcId] == nil then
					self._funcInfoList[funcId] = {}
					self._funcInfoList[funcId].go = go
					self._funcInfoList[funcId].parentGo = go
					self._funcInfoList[funcId].cellGo = go.transform:GetChild(0).gameObject
					self._funcInfoList[funcId].cellGo.name = "cell_" .. funcId

					local iconISC = goutil.findChildComponent(self._funcInfoList[funcId].cellGo, "iconIma", typeof(UIImageSpriteChange))

					iconISC.gameObject:GetComponent(goutil.Type_UIImage):SetNativeSize()
					iconISC:ChangeSprite(string.nilorempty(cfg.icon) and "icon_shangcheng" or cfg.icon)

					self._funcInfoList[funcId].redPoint = goutil.findChild(iconISC.gameObject, "redpointGo")
					self._funcInfoList[funcId].lockGo = goutil.findChild(self._funcInfoList[funcId].cellGo, "lockGo")

					local nameTxt = goutil.findChildTextComponent(self._funcInfoList[funcId].cellGo, "nameTxt")

					nameTxt.text = cfg.isHideName and "" or cfg.name

					GameUtil.SetActive(self._funcInfoList[funcId].lockGo, not isOpen)
					GameUtil.asBtn(self._funcInfoList[funcId].cellGo):AddClickListener(GameUtil.handler(self._onClickFuncBtn, self, funcId))
				end
			end
		end
	end

	MainUIController.instance:setExpandBtnsList(self._funcInfoList)
	GameUtil.setWidth(self._content, index * 95 + 5)
	GameUtil.setPos(self._content, self._curParams.localPos.x, self._curParams.localPos.y + 0.2777777777777778, self._curParams.localPos.z)
	self:_updateAllRedpoint()
end

function MainBtnExpandView:_updateAllRedpoint()
	if not self._isShowExpand then
		return
	end

	for funcId, item in pairs(self._funcInfoList or {}) do
		if funcId and item and item.redPoint then
			self:_updateSingleRedpoint(funcId, item.redPoint)
		end
	end
end

function MainBtnExpandView:_updateSingleRedpoint(funcId, redGo)
	if funcId == nil then
		return
	end

	if redGo == nil and self._funcInfoList and self._funcInfoList[funcId] then
		redGo = self._funcInfoList[funcId].redPoint
	end

	if redGo == nil then
		return
	end

	local list = MainActivityView.funcIDToRedpointID[funcId]

	if not list then
		GameUtil.SetActive(redGo, false)
	else
		local showPoint = false

		for _, id in ipairs(list) do
			if RedPointModel.instance:isActive(id) then
				showPoint = true

				break
			end
		end

		goutil.setActive(redGo, showPoint)
	end
end

function MainBtnExpandView:_onClickViewBtn()
	for _, item in pairs(self._btnItemList or {}) do
		if item then
			GameUtil.SetActive(item, false)
		end
	end

	self._funcInfoList = nil

	if self._curParams and self._curParams.fatFuncId then
		GlobalDispatcher:dispatch(GlobalNotify.MainBtnExpandViewClose, self._curParams.fatFuncId)
	end
end

function MainBtnExpandView:_onClickFuncBtn(funcId)
	if ViewMgr.instance:isOpen(ViewName.OtherCardView) or ViewMgr.instance:isOpen(ViewName.MyCardView) then
		return
	end

	if RoleController.instance:getIsReqingRoleInfo() then
		return
	end

	self._isShowExpand = false

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

	FuncOpenController.instance:reportClickBehavior(funcId)
	FuncOpenController.instance:onClickFunc(cfg)
end

return MainBtnExpandView
