-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tcpanduola/PanduolaBuffCell.lua

module("logic.extensions.timelimitedchallenge.view.tcpanduola.PanduolaBuffCell", package.seeall)

local PanduolaBuffCell = class("PanduolaBuffCell")

function PanduolaBuffCell:ctor(go)
	self.mainGO = go
	self._txtLv = goutil.findChildTextComponent(go, "txtLv")
	self._lvBg = goutil.findChild(go, "lvbg")
	self._downArrow = goutil.findChild(go, "downArrow")
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	self._imgEffect = Framework.ImageBigBG.GetFrom(go, "imgEffect")
end

function PanduolaBuffCell:updateWithPanduolaBuffId(buffId)
	local cfg = TimeLimitedConfig.instance:getBuffCfgById(buffId)

	self:updateWithPanduolaBuffCfg(cfg)
end

function PanduolaBuffCell:updateWithPetVerifyCfg(verifyCfg)
	GameUtil.SetActive(self._lvBg, false)

	if verifyCfg ~= nil then
		GameUtil.SetActive(self._lvBg, true)

		local buffCfg = BattleConfig.instance:getBuffCo(checknumber(verifyCfg.buffKey))
		local color = "60ee85"

		self._txtName.text = string.format(verifyCfg.name, color)
		self._txtDesc.text = string.format(verifyCfg.des, color)
		self._txtLv.text = string.format("Lv.%d", verifyCfg.level)

		GameUtil.SetActive(self._downArrow, false)

		local tempStr = string.split(verifyCfg.buffId, ":")
		local buffId = tempStr[1]
		local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

		if buffIcon then
			self._imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))
		end
	end
end

function PanduolaBuffCell:updateWithPanduolaBuffCfg(cfg)
	GameUtil.SetActive(self._lvBg, false)

	if cfg then
		GameUtil.SetActive(self._lvBg, true)

		local buffCfg = BattleConfig.instance:getBuffCo(checknumber(cfg.buffKey))

		if buffCfg == nil then
			buffCfg = BattleConfig.instance:getBuffCo(4538)
		end

		self._imgEffect:SetImage(GameUrl.getExpEventUrl(buffCfg.icon))

		local benefit = checknumber(cfg.benefit)

		GameUtil.SetActive(self._downArrow, benefit == 1 or benefit == 2)
		GameUtil.setUIImageSpriteIdx(self._downArrow, benefit - 1)

		if self._txtLv then
			self._txtLv.text = "Lv." .. cfg.grade
		end

		self._txtName.text = string.format("%s<color=#EB4642FF>%s级</color>", cfg.name, cfg.grade)
		self._txtDesc.text = cfg.desc
	end
end

function PanduolaBuffCell:setActive(isActive)
	self.mainGO:SetActive(isActive)
end

function PanduolaBuffCell:clear()
	uGuiUtil.clearImage(self._imgEffect.gameObject)
end

return PanduolaBuffCell
