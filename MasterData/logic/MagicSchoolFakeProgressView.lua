-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolFakeProgressView.lua

module("logic.extensions.magicschool.view.MagicSchoolFakeProgressView", package.seeall)

local MagicSchoolFakeProgressView = class("MagicSchoolFakeProgressView", ViewComponent)

function MagicSchoolFakeProgressView:ctor()
	MagicSchoolFakeProgressView.super.ctor(self)
end

function MagicSchoolFakeProgressView:unbindEvents()
	MagicSchoolFakeProgressView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MagicSchoolFakeProgressView:bindEvents()
	MagicSchoolFakeProgressView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MagicSchoolFakeProgressView:buildUI()
	MagicSchoolFakeProgressView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtProgress = self:getTxt("total/txtProgress")
	self._tablecell = self:getGo("scorollReward/rewardcell")
	self._tableview = self:getGo("scorollReward/tableview")
	self._viewport = self:getGo("scorollReward/tableview/viewport")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
end

function MagicSchoolFakeProgressView:onExit()
	MagicSchoolFakeProgressView.super.onExit(self)
	self._scrollList:dispose()
end

function MagicSchoolFakeProgressView:onEnter()
	MagicSchoolFakeProgressView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GeneralWorldProgressGetInfo, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.GeneralWorldProgressGainPrize, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 262007
	end

	self._actCfg = GeneralWorldProgressConfig.instance:getActCfgById(self._activityId)

	local planId = self._actCfg.prizePlanId

	self._prizeCfgs = GeneralWorldProgressConfig.instance:getprizeCfgsByPlanId(planId)

	GeneralWorldProgressController.instance:getInfo(self._activityId)
end

function MagicSchoolFakeProgressView:_onUpdate()
	self._curProgress = GeneralWorldProgressModel.instance:getCurProgress()

	local scoreList = {}

	for i, v in ipairs(self._prizeCfgs) do
		table.insert(scoreList, v.needScore)
	end

	self._txtProgress.text = string.format("<color=#0C7247>%d</color>名魔法师", self._curProgress)

	self._scrollList:reloadData(self._prizeCfgs)
	self._scrollList:updateUnderSlider(self._progressSlider, self._curProgress, scoreList)
end

function MagicSchoolFakeProgressView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local imgProgress = goutil.findChild(cell, "imgProgress")
	local spriteChangeComp = goutil.findChild(cell, "imgProgress"):GetComponent("UIImageSpriteChange")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local changeIdx = self._curProgress >= data.needScore and 1 or 0
	local canGetReward = self._curProgress >= data.needScore
	local hasGetReward = GeneralWorldProgressModel.instance:getIsGainPrize(data.prizeId)

	self:stopViewEffectUniGo(effect)

	if canGetReward and not hasGetReward then
		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effect, self._viewport.transform, true, nil, nil)
	end

	txtScore.text = data.needScore

	spriteChangeComp:SetState(changeIdx)
	imgProgress:GetComponent(goutil.Type_UIImage):SetNativeSize()
	MaterialMgr.setCellByCfg(data.prize, item)
	GameUtil.SetActive(geted, hasGetReward)
	GameUtil.SetActive(btnGet, canGetReward and not hasGetReward)
	GameUtil.addClickHandler(btnGet, function()
		local oneKeyGain = true

		GeneralWorldProgressController.instance:gainPrize(self._activityId, 0, oneKeyGain)
	end, self)
end

function MagicSchoolFakeProgressView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effect)
end

return MagicSchoolFakeProgressView
