-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetSourceView.lua

module("logic.extensions.handbook.view.PetSourceView", package.seeall)

local PetSourceView = class("PetSourceView", ViewComponent)

function PetSourceView:ctor()
	PetSourceView.super.ctor(self)
end

function PetSourceView:destroyUI()
	if self._scrollList then
		self._scrollList:dispose()

		self._scrollList = nil
	end

	PetSourceView.super.destroyUI(self)
end

function PetSourceView:onExitFinished()
	PetSourceView.super.onExitFinished(self)
end

function PetSourceView:onEnterFinished()
	PetSourceView.super.onEnterFinished(self)
end

function PetSourceView:unbindEvents()
	PetSourceView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PetSourceView:bindEvents()
	PetSourceView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PetSourceView:onExit()
	PetSourceView.super.onExit(self)
end

function PetSourceView:buildUI()
	PetSourceView.super.buildUI(self)

	local main = self:getGo("main")

	self._closeButton = self:getBtn("btnClose")

	local waysGo = goutil.findChild(main, "ways")
	local wayTemplate = goutil.findChild(waysGo, "1")

	GameUtil.SetActive(wayTemplate, false)

	self._scrollList = ScrollerList.create(waysGo, wayTemplate, GameUtil.handler(self._updateWayCell, self), GameUtil.handler(self._clearWayCell, self))
	self._txtName = goutil.findChildTextComponent(main, "item/Name")
	self._imgQua = goutil.findChildComponent(main, "item/imgQua", "UIImageSpriteChange")
	self._imgIcon = goutil.findChild(main, "item/imgIcon")
	self._imgRare = goutil.findChildComponent(main, "item/imgRare", "Image")
	self._imgRareChange = self._imgRare:GetComponent("UIImageSpriteChange")
end

function PetSourceView:onEnter()
	PetSourceView.super.onEnter(self)

	self.jumpCallBack = self._viewPresentor._openParam[2]

	local raceId = checknumber(self:getFirstParam())
	local petCfg = CharacterConfig.instance:getPetCo(raceId)

	self._txtName.text = petCfg.name

	local infos = string.split(petCfg.source, ",")
	local _curViewDatas = {}

	for k, v in pairs(infos or {}) do
		if checknumber(v) > 0 then
			local cf = ItemConfig.instance:getSourceCfg(v)

			if cf == nil or (not self:getFuncIsOpen(cf.funcId) or not FuncOpenController.instance:checkOpenTime(cf.openTime)) and checknumber(cf.openType) == 1 then
				-- block empty
			else
				table.insert(_curViewDatas, v)
			end
		end
	end

	self._scrollList:reloadData(_curViewDatas)

	local rare = CharacterConfig.instance:getRareByAwakenLv(petCfg.initAwakenLv, petCfg.raceId)

	self._imgQua:SetState(rare + 1)
	self._imgRareChange:SetState(rare - 1)
	self._imgRare:SetNativeSize()

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCfg.faceIds))
	local icon = modelCo == nil and "" or modelCo.headName

	uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(icon))
end

function PetSourceView:_updateWayCell(view, cell, data, tag)
	local cellGo = cell.gameObject
	local wayId = checknumber(data)
	local lock = goutil.findChild(cellGo, "lock")
	local txtContent = goutil.findChildTextComponent(cellGo, "txtContent")
	local btn = Framework.ButtonAdapter.Get(cellGo)
	local cfg = ItemConfig.instance:getSourceCfg(wayId)

	GameUtil.SetActive(lock, false)

	if cfg then
		GameUtil.SetActive(lock, not FuncOpenController.instance:checkOpenTime(cfg.openTime))
		btn:AddClickListener(function()
			self:_onClickWay(cfg)
		end)

		txtContent.text = cfg.name
	end
end

function PetSourceView:_clearWayCell(cell)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:RemoveClickListener()
end

function PetSourceView:getFuncIsOpen(funcId)
	local arr = string.splitToNumber(funcId, "#")
	local boo = true

	for i, v in ipairs(arr) do
		if v > 0 then
			boo = boo and FuncOpenModel.instance:getFuncIsOpen(v)
		end
	end

	return boo
end

function PetSourceView:_onClickWay(cfg)
	local isLock = not FuncOpenController.instance:getConditionReached(cfg.openCondition, cfg.openTime)

	if isLock then
		FloatWordMgr.instance:show(cfg.lockedTips)
	else
		local raceId = checknumber(self:getFirstParam())
		local mo = MaterialModel.instance:createMo(MatType.Pet, raceId)

		GameUtil.callBack(self.jumpCallBack)
		self:close()
		ViewAutoShowController.instance:saveCurModalView()
		GotoMgr.gotoByString(cfg.jumpTo, mo)
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickGotoPetScene)
end

function PetSourceView:_onClickClose()
	self:close()
end

return PetSourceView
