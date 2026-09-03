-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/component/LeadStageArenaReportCell.lua

LeadStageArenaReportCell = class("LeadStageArenaReportCell", DisposableObject, _M)

function LeadStageArenaReportCell:initialize(info)
	super.initialize(self)

	local resFile = "asset/ui/LeadStageAreaReportCell.csb"

	self._view = cc.CSLoader:createNode(resFile)
	self._mediator = info.mediator

	self:setupView()
end

function LeadStageArenaReportCell:dispose()
	super.dispose()
end

function LeadStageArenaReportCell:getView()
	return self._view
end

function LeadStageArenaReportCell:setupView()
	self:initWidgetInfo()
end

function LeadStageArenaReportCell:initWidgetInfo()
	local bg = self:getView():getChildByName("bg")

	self._video = bg:getChildByName("button_video")
	self._share = bg:getChildByName("button_share")
	self._iconBg = bg:getChildByName("icon_bg")
	self._iconBg_r = bg:getChildByName("icon_bg1")

	local panel = bg:getChildByFullName("panel1")

	self._name = panel:getChildByName("role_name")
	self._level = panel:getChildByName("level")
	self._name_r = panel:getChildByName("role_name1")
	self._level_r = panel:getChildByName("level1")
	self._changeBg = panel:getChildByFullName("changeBg")
	self._sign = panel:getChildByFullName("changeBg.sign")
	self._increase = panel:getChildByFullName("changeBg.increase")
	self._txtEscape = panel:getChildByFullName("text_escape")
	self._imgResult = panel:getChildByName("result")
	self._tipsText = ccui.Text:create("", TTF_FONT_FZYH_M, 16)

	self._tipsText:addTo(panel):posite(85, 20)
	GameStyle:setCommonOutlineEffect(self._level)
	GameStyle:setCommonOutlineEffect(self._level_r)

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(202, 108, 78, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(111, 103, 104, 255)
		}
	}

	self._txtEscape:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function LeadStageArenaReportCell:refreshReportData(data)
	local attackerData = data:getAttacker()
	local defenseData = data:getDefender()
	local showData, showMyData
	local raise = data:getBaseWinCoin() + data:getExtraWinCoin()
	local isAttacker

	if self._mediator:getDevelopSystem():getRid() == attackerData:getId() then
		showData = defenseData
		showMyData = attackerData
		isAttacker = true
	else
		isAttacker = false
		showMyData = defenseData
		showData = attackerData
	end

	self:setupMyInfo(showMyData)

	local headId = showData:getHeadImg() or "Master_XueZhan"
	local level = showData:getLevel()
	local nickName = showData:getNickname()

	self._iconBg_r:removeAllChildren()

	local headicon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		id = headId
	})

	headicon:addTo(self._iconBg_r):center(self._iconBg_r:getContentSize())
	self._name_r:setString(nickName)
	self._level_r:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. level)

	local isLeave = data:getIsLeaveBattle()

	self._txtEscape:setVisible(isLeave)
	self._changeBg:setVisible(not isLeave)

	if not isLeave then
		self._sign:loadTexture(leadStageArenaPicPath, ccui.TextureResType.plistType)
		self._sign:setScale(0.7)

		if raise <= 0 then
			self._increase:setString((raise == 0 or nil) and ("-" .. raise or raise))
			self._increase:setColor(cc.c3b(235, 19, 68))
		else
			self._increase:setString("+" .. raise)
			self._increase:setColor(cc.c3b(181, 235, 19))
		end
	end

	local result = isAttacker and data:getAttackerWin()

	if result then
		self._imgResult:getChildByName("text"):setString(Strings:get("Arena_Victory"))
		self._imgResult:setGray(false)
	else
		self._imgResult:getChildByName("text"):setString(Strings:get("Arena_Defeat"))
		self._imgResult:setGray(true)
	end

	self._video:setVisible(data:getWatchFlag())
end

function LeadStageArenaReportCell:setupMyInfo(showData)
	local headId = showData:getHeadImg() or "YFZZhu"
	local level = showData:getLevel()
	local nickName = showData:getNickname()

	self._iconBg:removeAllChildren()

	local headicon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		id = headId
	})

	headicon:addTo(self._iconBg):center(self._iconBg:getContentSize())
	self._name:setString(nickName)
	self._level:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. level)
end
