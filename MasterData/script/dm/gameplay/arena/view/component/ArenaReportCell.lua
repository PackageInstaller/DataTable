-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/component/ArenaReportCell.lua

ArenaReportCell = class("ArenaReportCell", DisposableObject, _M)

local kPicUp = "asset/common/st_img_up.png"
local kPicDown = "asset/common/common_icon_jt_2.png"

function ArenaReportCell:initialize(info)
	super.initialize(self)

	local resFile = "asset/ui/ArenaReportCell.csb"

	self._view = cc.CSLoader:createNode(resFile)
	self._mediator = info.mediator

	self:setupView()
end

function ArenaReportCell:dispose()
	super.dispose()
end

function ArenaReportCell:getView()
	return self._view
end

function ArenaReportCell:setupView()
	self:initWidgetInfo()
end

function ArenaReportCell:initWidgetInfo()
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
	self._imgResult = panel:getChildByName("result")
	self._tipsText = ccui.Text:create("", TTF_FONT_FZYH_M, 16)

	self._tipsText:addTo(panel):posite(85, 20)
	GameStyle:setCommonOutlineEffect(self._level)
	GameStyle:setCommonOutlineEffect(self._level_r)
end

function ArenaReportCell:refreshReportData(data)
	local attackerData = data:getAttacker()
	local defenseData = data:getDefender()
	local type = data.getReprotType and data:getReprotType() or nil
	local showData, showMyData
	local raise = data:getRankChange()
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

	if type and type == "RTPK" then
		self._increase:setString(raise)
		self._tipsText:setVisible(false)

		if raise == 0 then
			if data:getOutOfTime() then
				self._tipsText:setVisible(true)
				self._tipsText:setString(Strings:get("RTPK_BattleRecord_ScoreTip"))

				local var_6_0

				if data:getAttackerWin() then
					var_6_0 = kPicUp or kPicDown
				end
			end

			self._sign:loadTexture(var_6_0)
			self._increase:setString((data:getAttackerWin() or nil) and ("+" .. raise or "-" .. raise))
			self._increase:setColor(data:getAttackerWin() and cc.c3b(181, 235, 19) or cc.c3b(235, 19, 68))
		elseif raise <= 0 then
			self._sign:loadTexture(kPicDown)
			self._increase:setColor(cc.c3b(235, 19, 68))
		else
			self._sign:loadTexture(kPicUp)
			self._increase:setColor(cc.c3b(181, 235, 19))
		end
	elseif raise <= 0 then
		self._changeBg:setVisible(false)
	else
		self._changeBg:setVisible(true)
		self._sign:loadTexture(kPicUp)
		self._increase:setString(Strings:get("RANK_UI13", {
			num = raise
		}))
	end

	local result = isAttacker and data:getAttackerWin()

	if (type and type == "NEWARENA" or nil) and (self._mediator:getDevelopSystem():getRid() == attackerData:getId() and data:getAttackerWin() or not data:getAttackerWin()) then
		self._imgResult:getChildByName("text"):setString(Strings:get("Arena_Victory"))
		self._imgResult:setGray(false)
	else
		self._imgResult:getChildByName("text"):setString(Strings:get("Arena_Defeat"))
		self._imgResult:setGray(true)
	end
end

function ArenaReportCell:setupMyInfo(showData)
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
