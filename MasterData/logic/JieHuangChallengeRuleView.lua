-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiehuangchallenge/view/JieHuangChallengeRuleView.lua

module("logic.extensions.jiehuangchallenge.view.JieHuangChallengeRuleView", package.seeall)

local JieHuangChallengeRuleView = class("JieHuangChallengeRuleView", ViewComponent)

function JieHuangChallengeRuleView:ctor()
	JieHuangChallengeRuleView.super.ctor(self)
end

function JieHuangChallengeRuleView:buildUI()
	JieHuangChallengeRuleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
end

function JieHuangChallengeRuleView:bindEvents()
	JieHuangChallengeRuleView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function JieHuangChallengeRuleView:unbindEvents()
	JieHuangChallengeRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function JieHuangChallengeRuleView:onEnter()
	JieHuangChallengeRuleView.super.onEnter(self)

	self._tableScroll = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityCfg = MiyaChallengeConfig.instance:getActivityCfg(MiyaChallengeModel.instance:getActivityId())
	self._tierCfg = MiyaChallengeConfig.instance:getTierStageCfg(self._activityCfg.tierPlanId, MiyaChallengeModel.instance:getTierId())
	self._randomCfg = nil

	if MiyaChallengeModel.instance:getBigStageId() == 1 then
		self._randomCfg = MiyaChallengeConfig.instance:getRandomCfg(self._tierCfg.firstRandomPlanId)
	elseif MiyaChallengeModel.instance:getBigStageId() == 2 then
		self._randomCfg = MiyaChallengeConfig.instance:getRandomCfg(self._tierCfg.secondRandomPlanId)
	elseif MiyaChallengeModel.instance:getBigStageId() == 3 then
		self._randomCfg = MiyaChallengeConfig.instance:getRandomCfg(self._tierCfg.thirdRandomPlanId)
	end

	self:_refreshView()
end

function JieHuangChallengeRuleView:onExit()
	JieHuangChallengeRuleView.super.onExit(self)
	self._tableScroll:dispose()
end

function JieHuangChallengeRuleView:_refreshView()
	local list = {}

	for i = 1, 3 do
		local typeList = {}
		local canload = true

		table.insert(typeList, {
			isTitle = true,
			type = i
		})

		for j = 1, #self._randomCfg[i][0].ids do
			table.insert(typeList, {
				isTitle = false,
				type = i,
				id = self._randomCfg[i][0].ids[j]
			})

			if checknumber(self._randomCfg[i][0].ids[j]) == 0 then
				canload = false
			end
		end

		if canload == true then
			for j, cfg in ipairs(typeList) do
				table.insert(list, cfg)
			end
		end
	end

	self._tableScroll:reloadData(list)
end

function JieHuangChallengeRuleView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local titleGo = goutil.findChild(go, "arrow")
	local descGo = goutil.findChild(go, "num")
	local txtType = goutil.findChildTextComponent(go, "arrow/txt")
	local txtNum = goutil.findChildTextComponent(go, "num/imgNum/txtNum")
	local txtDesc = goutil.findChildTextComponent(go, "num/txtDesc")
	local arrowChange = goutil.findChildComponent(go, "arrow/icon", "UIImageSpriteChange")

	if data.isTitle == true then
		GameUtil.SetActive(titleGo, true)
		GameUtil.SetActive(descGo, false)

		if data.type == 1 then
			arrowChange:ChangeSprite("board_jiehuangtz_07")

			txtType.text = lang("属性加成")
		elseif data.type == 2 then
			arrowChange:ChangeSprite("board_jiehuangtz_08")

			txtType.text = lang("上阵限制")
		elseif data.type == 3 then
			arrowChange:ChangeSprite("board_jiehuangtz_09")

			txtType.text = lang("通关条件")
		end
	else
		GameUtil.SetActive(titleGo, false)
		GameUtil.SetActive(descGo, true)

		txtNum.text = MiyaChallengeConfig.instance:getNum(data.type, data.id) or "未定义"

		if data.type == 1 then
			txtDesc.text = MiyaChallengeConfig.instance:getBuffCfg(data.id).des
		elseif data.type == 2 then
			txtDesc.text = FormationValidatorConfig.instance:getFormationValidatorCfg(data.id).desc
		elseif data.type == 3 then
			txtDesc.text = MiyaChallengeConfig.instance:getWindDesc(3, data.id) or "未定义"
		end
	end
end

function JieHuangChallengeRuleView:_clearCell(cell)
	return
end

function JieHuangChallengeRuleView:_onClickClose()
	self:close()
end

return JieHuangChallengeRuleView
