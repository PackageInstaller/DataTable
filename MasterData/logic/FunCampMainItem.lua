-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampMainItem.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampMainItem", package.seeall)

local FunCampMainItem = class("FunCampMainItem")

function FunCampMainItem:ctor(go)
	self.mainGO = go
	self._selectGo = goutil.findChild(go, "select")
	self._txtName = goutil.findChildTextComponent(go, "name/txt")
	self._btnFeature = Framework.ButtonAdapter.GetFrom(go, "btnFeatures")
	self._btnBuff = Framework.ButtonAdapter.GetFrom(go, "btnBuff")
	self._bubbleGo = goutil.findChild(go, "bubble")
	self._txtBubble = goutil.findChildTextComponent(go, "bubble/txtDesc")
	self._rankChange = goutil.findChild(go, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	self._nameGo = goutil.findChild(go, "name")
	self._txtCampValue = goutil.findChildTextComponent(go, "score/txtCampValue")
	self._txtPersonalValue = goutil.findChildTextComponent(go, "score/txtPersonalValue")
	self._campName = goutil.findChildTextComponent(go, "txtName")
	self._featurePosGo = goutil.findChild(go, "featuresPos")
	self._buffPosGo = goutil.findChild(go, "buffPos")

	self._btnFeature:AddClickListener(self._onClickFeature, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self:_resetGo()
end

function FunCampMainItem:_resetGo()
	goutil.setActive(self._selectGo, false)
	goutil.setActive(self._bubbleGo, false)
	goutil.setActive(self._rankChange.gameObject, false)
	goutil.setActive(self._nameGo.gameObject, false)
	goutil.setActive(self._txtCampValue.gameObject, false)
	goutil.setActive(self._txtPersonalValue.gameObject, false)
end

function FunCampMainItem:initData(activityId, groupId, campId)
	self:_resetGo()

	self._activityId = activityId
	self._campId = campId
	self._cfg = FunCampConfig.instance:getCampGroupCfg(groupId, campId)
	self._txtName.text = self._cfg.name
	self._campName.text = self._cfg.name
	self._campInspireValue = 0
	self._reportBehavior = string.split(self._cfg.reportBehavior, "#")
end

function FunCampMainItem:updateData(data)
	self:_resetGo()

	self._campInspireValue = data.campInspireValue

	if data.isSelectCamp then
		goutil.setActive(self._rankChange.gameObject, true)
		goutil.setActive(self._nameGo.gameObject, true)
		goutil.setActive(self._txtCampValue.gameObject, true)

		local isSelfSelect = data.selectCampId == self._campId

		goutil.setActive(self._txtPersonalValue.gameObject, isSelfSelect)
		goutil.setActive(self._selectGo, isSelfSelect)
		self._rankChange:SetState(data.rank - 1)

		local curStage = FunCampController.instance:getCurStage()
		local str = ""
		local campValue = 0
		local personValue = 0

		if curStage <= FunCampController.Inspire then
			str = "鼓舞值"
			campValue = data.campInspireValue
			personValue = data.personalInspireValue
		else
			str = "积分"
			campValue = data.campScore
			personValue = data.personScore
		end

		self._txtCampValue.text = string.format("阵营%s：%d", str, campValue)

		if isSelfSelect then
			self._txtPersonalValue.text = string.format("个人%s：%d", str, personValue)
		end

		goutil.setActive(self._campName.gameObject, false)
	end
end

function FunCampMainItem:reset()
	return
end

function FunCampMainItem:getCampId()
	return self._campId
end

function FunCampMainItem:_onClickFeature()
	local title = "阵营特点"
	local desc = self._cfg.desc
	local parentGo = self._featurePosGo

	GlobalDispatcher:dispatch(GlobalNotify.FunCampShowTip, title, desc, parentGo)
	SurveyController.instance:reportBehavior(self._reportBehavior[2])
end

function FunCampMainItem:_onClickBuff()
	local title = "Buff特点"
	local desc = string.format("当前鼓舞值：%s\nBuff触发机制，根据阵营鼓舞值触发：\n\n", self._campInspireValue)
	local parentGo = self._buffPosGo
	local cfg = FunCampConfig.instance:getBuffCfg(self._cfg.buffPlanId, self._campInspireValue)
	local list = FunCampConfig.instance:getBuffList(self._cfg.buffPlanId)
	local colorPrefix = "<color=#eb4642>"
	local colorPost = "</color>"

	for i, v in ipairs(list) do
		desc = i ~= #list and (cfg and v.id == cfg.id and desc .. colorPrefix .. v.decs .. colorPost .. "\n\n" or desc .. v.decs .. "\n\n") or cfg and v.id == cfg.id and desc .. colorPrefix .. v.decs .. colorPost or desc .. v.decs
	end

	GlobalDispatcher:dispatch(GlobalNotify.FunCampShowTip, title, desc, parentGo)
	SurveyController.instance:reportBehavior(self._reportBehavior[1])
end

return FunCampMainItem
