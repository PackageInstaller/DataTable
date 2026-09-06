-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetAttrPopUpView.lua

module("logic.extensions.cutepet.view.CutePetAttrPopUpView", package.seeall)

local CutePetAttrPopUpView = class("CutePetAttrPopUpView", ViewComponent)

function CutePetAttrPopUpView:ctor()
	CutePetAttrPopUpView.super.ctor(self)
end

function CutePetAttrPopUpView:destroyUI()
	CutePetAttrPopUpView.super.destroyUI(self)
end

function CutePetAttrPopUpView:onExitFinished()
	CutePetAttrPopUpView.super.onExitFinished(self)
end

function CutePetAttrPopUpView:onEnterFinished()
	CutePetAttrPopUpView.super.onEnterFinished(self)
end

function CutePetAttrPopUpView:unbindEvents()
	CutePetAttrPopUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	self._customInput:RemoveListener()
end

function CutePetAttrPopUpView:bindEvents()
	CutePetAttrPopUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, GameUtil.handler(self._closeView, self))
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function CutePetAttrPopUpView:onExit()
	CutePetAttrPopUpView.super.onExit(self)
end

function CutePetAttrPopUpView:buildUI()
	CutePetAttrPopUpView.super.buildUI(self)

	self._Content = self:getGo("content")
	self._adjustPosition = self._Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Content)
	self._mainAttrTable = self:getGo("content/mainAttr")
	self._detailAttrTable = self:getGo("content/detail")
	self._attrCell = self:getGo("content/attrCell")
	self._btnClose = self:getGo("btnClose")
end

function CutePetAttrPopUpView:onEnter()
	CutePetAttrPopUpView.super.onEnter(self)

	self._mainAttrList = ScrollerList.create(self._mainAttrTable, self._attrCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._detailAttrList = ScrollerList.create(self._detailAttrTable, self._attrCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))

	local params = self:getOpenParam()

	if params then
		self:_adjustView()

		self.parentPresentor = params[3]

		self:checkPresentor()
	else
		return
	end

	local petId = params[4]
	local mainAttrTypeMap = params[5]

	if checknumber(petId) <= 0 then
		self:_closeView()

		return
	end

	self._petMo = CutePetModel.instance:getCutePeMo(petId)
	self._initProps = self._petMo:getInitialActiveProps()

	local attrSort = self._petMo:getSortAttrList()
	local mainAttrData = {}
	local detailAttrData = {}

	for i, v in ipairs(attrSort) do
		if mainAttrTypeMap[v] == true then
			table.insert(mainAttrData, {
				attrType = v,
				num = self._petMo.attr[v]
			})
		else
			table.insert(detailAttrData, {
				attrType = v,
				num = self._petMo.attr[v]
			})
		end
	end

	self._mainAttrList:reloadData(mainAttrData)
	self._detailAttrList:reloadData(detailAttrData)
end

function CutePetAttrPopUpView:_adjustView()
	local pos = self._viewPresentor._openParam[1]

	self.pos = pos
	self.sizeDelta = self._viewPresentor._openParam[2]

	if pos then
		GameUtil.SetActive(self.mainGO, false)
		settimer(0.1, self.showMainGo, self, false)
	else
		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

function CutePetAttrPopUpView:showMainGo()
	GameUtil.SetActive(self.mainGO, true)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
	self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], self.sizeDelta[2])
	self:checkPresentor()
end

function CutePetAttrPopUpView:checkPresentor(callback)
	if not self.parentPresentor or not self.parentPresentor:isOpen() then
		self:_closeView()

		return
	end

	GameUtil.callBack(callback)
end

function CutePetAttrPopUpView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtType = goutil.findChildTextComponent(go, "TxtC_Name")
	local txtQuality = goutil.findChildTextComponent(go, "txtQuality")
	local txtNum = goutil.findChildTextComponent(go, "TxtC_Value")
	local txtColorChange = goutil.findChildComponent(go, "txtQuality", "UITextColorChange")
	local typeChange = goutil.findChildComponent(go, "ImgC_Icon", "UIImageSpriteChange")

	txtType.text = GameEnum.AttrTypeName[data.attrType]

	typeChange:SetState(data.attrType - 1)

	txtNum.text = data.num >= 1 and string.format("%d", math.floor(data.num)) or string.format("%.2f%%", data.num * 100)

	local gradingCfgs = CutePetConfig.instance:getPropertyGradingCfg(GameEnum.AttrTypeName[data.attrType])

	txtQuality.text = ""

	if gradingCfgs and self._initProps[data.attrType] then
		for i, v in ipairs(gradingCfgs) do
			if self._initProps[data.attrType] >= v.genRange[1] and self._initProps[data.attrType] < v.genRange[2] then
				txtQuality.text = v.grade

				txtColorChange:SetState(v.color - 1)

				break
			end
		end
	else
		txtQuality.text = ""
	end
end

function CutePetAttrPopUpView:_clearAttrCell(cell)
	return
end

function CutePetAttrPopUpView:_onCustomInputCallback(hover)
	if not hover then
		self:_closeView()
	end
end

function CutePetAttrPopUpView:_closeView()
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.CloseCutePetEquipViewBlackMask)
end

return CutePetAttrPopUpView
