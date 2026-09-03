-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerBuffChooseMediator.lua

TowerBuffChooseMediator = class("TowerBuffChooseMediator", DmAreaViewMediator, _M)

TowerBuffChooseMediator:has("_towerSystem", {
	is = "rw"
}):injectWith("TowerSystem")

local kBtnHandlers = {
	["main.team_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onTeamClick"
	},
	["main.list_panel.buff_1"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onBuffClick"
	},
	["main.list_panel.buff_2"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onBuffClick"
	},
	["main.list_panel.buff_3"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onBuffClick"
	},
	["main.info_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onBuffRuleClick"
	}
}

function TowerBuffChooseMediator:initialize()
	super.initialize(self)
end

function TowerBuffChooseMediator:dispose()
	super.dispose(self)
end

function TowerBuffChooseMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function TowerBuffChooseMediator:enterWithData(data)
	self:initData(data)
	self:initNode()
	self:setupTopInfo()
	self:initContent()
	self:setupSkill()
end

function TowerBuffChooseMediator:initData(data)
	self._buffs = data.buffs
end

function TowerBuffChooseMediator:initNode()
	self._main = self:getView():getChildByFullName("main")

	GameStyle:setCommonOutlineEffect(self:getView():getChildByFullName("main.title.name"))
end

function TowerBuffChooseMediator:setupTopInfo()
	local topInfoNode = self._main:getChildByName("top_info")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		title = self._towerSystem:getCurTowerName(),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local num = string.len(self._towerSystem:getCurTowerName())

	self._main:getChildByName("info_btn"):setPositionX(80 * num / 3)
end

function TowerBuffChooseMediator:initContent()
	self._buffListView = {}
	self._buffListView[1] = {}
	self._buffListView[1].skill = self._main:getChildByFullName("list_panel.buff_1.skill")
	self._buffListView[1].name = self._main:getChildByFullName("list_panel.buff_1.name")
	self._buffListView[1].desc = self._main:getChildByFullName("list_panel.buff_1.desc")
	self._buffListView[2] = {}
	self._buffListView[2].skill = self._main:getChildByFullName("list_panel.buff_2.skill")
	self._buffListView[2].name = self._main:getChildByFullName("list_panel.buff_2.name")
	self._buffListView[2].desc = self._main:getChildByFullName("list_panel.buff_2.desc")
	self._buffListView[3] = {}
	self._buffListView[3].skill = self._main:getChildByFullName("list_panel.buff_3.skill")
	self._buffListView[3].name = self._main:getChildByFullName("list_panel.buff_3.name")
	self._buffListView[3].desc = self._main:getChildByFullName("list_panel.buff_3.desc")

	local teamName = self._main:getChildByFullName("team_btn.name")
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(211, 220, 252, 255)
		}
	}

	teamName:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	teamName:enableOutline(cc.c4b(28, 18, 38, 153), 1)
end

function TowerBuffChooseMediator:setupSkill()
	for i = 1, 3 do
		local skillId = self._buffs[tostring(i - 1)]
		local skill = ConfigReader:getRecordById("Skill", skillId)

		self._buffListView[i].name:setString(Strings:get(skill.Name))

		local desc = Strings:get(skill.Desc)

		self._buffListView[i].desc:getChildByFullName("text"):setString(desc)

		local info = {
			levelHide = true,
			id = skill.Id,
			skillType = skill.Type
		}

		print("TowerBuffChooseMediator setupSkill: " .. info.id)

		local newSkillNode = IconFactory:createMasterSkillIcon(info)

		newSkillNode:setAnchorPoint(0.5, 0.5)
		newSkillNode:setScale(0.75)
		newSkillNode:setPosition(cc.p(10, 13))
		newSkillNode:getChildByTag(668):setTouchEnabled(true)
		self._buffListView[i].skill:removeAllChildren()
		self._buffListView[i].skill:addChild(newSkillNode)
		self._buffListView[i].skill:setScale(1.1)
	end
end

local BuffNodeTag = {
	"1548",
	"1557",
	"1563"
}

function TowerBuffChooseMediator:onBuffClick(sender)
	local tag = sender:getTag()

	for i = 1, #BuffNodeTag do
		if BuffNodeTag[i] == tostring(tag) then
			local buffId = self._buffs[tostring(i - 1)]

			self:onBuffChoose(buffId)
		end
	end
end

function TowerBuffChooseMediator:onTeamClick()
	self._towerSystem:showTowerTeamBattleView()
end

function TowerBuffChooseMediator:leaveWithData()
	self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
		viewName = "TowerMainView"
	}))
end

function TowerBuffChooseMediator:onClickBack()
	self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
		viewName = "TowerMainView"
	}))
end

function TowerBuffChooseMediator:onBuffChoose(buffId)
	local towerId = self._towerSystem:getCurTowerId()

	self._towerSystem:requestSelectPointBuff(towerId, buffId, function()
		self._towerSystem:checkTowerBattleEnd()
	end)
end

function TowerBuffChooseMediator:onBuffRuleClick()
	local buffKey = "Tower_1_RuleText"
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", buffKey, "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {
			time = TimeUtil:getSystemResetDate()
		}
	}))
end
