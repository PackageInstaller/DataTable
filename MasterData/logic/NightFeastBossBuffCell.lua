-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossBuffCell.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossBuffCell", package.seeall)

local NightFeastBossBuffCell = class("NightFeastBossBuffCell")

function NightFeastBossBuffCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._buffIcon = goutil.findChild(go, "left/buffIcon")
	self._txtName = goutil.findChildTextComponent(go, "left/txtName")
	self._btnLevelUp = Framework.ButtonAdapter.GetFrom(go, "left/btnLevelUp")
	self._txtBtnLevelUp = goutil.findChildTextComponent(go, "left/btnLevelUp/txt")
	self._txtNum = goutil.findChildTextComponent(go, "left/txtNum")
	self._txtNumDesc = goutil.findChildTextComponent(go, "left/txtNum/txt")
	self._coinIcon = goutil.findChild(go, "left/txtNum/coinIcon")
	self._maxLevelGo = goutil.findChild(go, "left/txtMax")
	self._tableviewGo = goutil.findChild(go, "tableview")
	self._tablecellGo = goutil.findChild(go, "tablecell")
	self._scrollList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._btnLevelUp:AddClickListener(self._onClickLevelUp, self)
end

function NightFeastBossBuffCell:init(data)
	self._data = data

	local cfg = self._data[0]

	self._cfg = cfg

	local actcfg = NightFeastBossConfig.instance:getActivityCfg(cfg.activityId)

	uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.iconPath))
	uGuiUtil.setSpriteToImage(self._coinIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(actcfg.buffIconPath))

	self._txtName.text = cfg.buffName

	local maxLv = #self._data
	local curLv = NightFeastBossModel.instance:getBuffLv(cfg.activityId, cfg.buffId)

	self._txtBtnLevelUp.text = curLv == 0 and "解锁" or maxLv <= curLv and "已满级" or "升级"
	self._txtNumDesc.text = curLv == 0 and "解锁：" or "升级："

	if curLv < maxLv then
		GameUtil.SetActive(self._maxLevelGo, false)
		GameUtil.SetActive(self._btnLevelUp, true)
		GameUtil.SetActive(self._txtNum, true)

		local cfgNext = NightFeastBossConfig.instance:getBuffCfg(cfg.activityId, cfg.buffId, curLv + 1)

		self._txtNum.text = "x" .. cfgNext.costPoint

		local needPoint = cfgNext.costPoint
		local leftPoint = NightFeastBossModel.instance:getLeftBuffPoint(cfg.activityId)

		GameUtil.SetGray(self._btnLevelUp, leftPoint < needPoint)
	else
		GameUtil.SetActive(self._maxLevelGo, true)
		GameUtil.SetActive(self._btnLevelUp, false)
		GameUtil.SetActive(self._txtNum, false)
		GameUtil.SetGray(self._btnLevelUp, false)
	end

	local list = {}

	for i, v in ipairs(self._data) do
		table.insert(list, v)
	end

	printInfo("test NightFeastBossBuffCell:init >>", #self._data, #list, self._data[0], list[0])
	self._scrollList:reloadData(list)
	self._scrollList:dragNotifyParent()
end

function NightFeastBossBuffCell:clear()
	uGuiUtil.clearImage(self._buffIcon)
	MaterialMgr.clearIcon(self._coinIcon)
	self._scrollList:dispose()
end

function NightFeastBossBuffCell:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtLv = goutil.findChildTextComponent(cell, "txtLv")
	local lock = goutil.findChild(cell, "lock")
	local curLv = NightFeastBossModel.instance:getBuffLv(data.activityId, data.buffId)

	GameUtil.SetActive(lock, curLv < data.buffLvl)

	txtDesc.text = data.buffDesc
	txtLv.text = "Lv." .. data.buffLvl
end

function NightFeastBossBuffCell:_clearCell(cell)
	return
end

function NightFeastBossBuffCell:_onClickLevelUp()
	local maxLv = #self._data
	local curLv = NightFeastBossModel.instance:getBuffLv(self._cfg.activityId, self._cfg.buffId)

	if maxLv <= curLv then
		FloatWordMgr.instance:show("已满级")

		return
	end

	local cfg = NightFeastBossConfig.instance:getBuffCfg(self._cfg.activityId, self._cfg.buffId, curLv + 1)
	local actcfg = NightFeastBossConfig.instance:getActivityCfg(cfg.activityId)
	local needPoint = cfg.costPoint
	local leftPoint = NightFeastBossModel.instance:getLeftBuffPoint(self._cfg.activityId)

	if leftPoint < needPoint then
		local tips = string.format("请通关Buff挑战来获取%s吧", actcfg.buffPointName)

		FloatWordMgr.instance:show(tips)

		return
	end

	NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgLvlUpBuffReq(self._cfg.activityId, self._cfg.buffId)
end

return NightFeastBossBuffCell
