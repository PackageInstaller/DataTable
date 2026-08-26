-- chunkname: @modules/logic/versionactivity3_6/yami/view/common/V3a6YaMiAttrPanel.lua

module("modules.logic.versionactivity3_6.yami.view.common.V3a6YaMiAttrPanel", package.seeall)

local V3a6YaMiAttrPanel = class("V3a6YaMiAttrPanel", LuaCompBase)

function V3a6YaMiAttrPanel:init(go)
	self.viewGO = go
	self._goattrroot = gohelper.findChild(self.viewGO, "Att")
	self._attrItems = self:getUserDataTb_()

	for _, attrType in pairs(V3a6YaMiEnum.AttrType) do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self._goattrroot, "Att" .. attrType)
		item.txtnum = gohelper.findChildText(item.go, "#txt_num")
		item.txtname = gohelper.findChildText(item.go, "#txt_name")
		item.imgicon = gohelper.findChildImage(item.go, "#txt_num/icon")
		item.gohighbg = gohelper.findChild(item.go, "#go_highbg")
		item.numColor = item.txtnum and item.txtnum.color
		item.nameColor = item.txtname and item.txtname.color
		self._attrItems[attrType] = item
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiAttrPanel:addEventListeners()
	return
end

function V3a6YaMiAttrPanel:removeEventListeners()
	return
end

function V3a6YaMiAttrPanel:_editableInitView()
	self._hightColor = GameUtil.parseColor("#FF9D67")
	self._attrValue = {}
end

function V3a6YaMiAttrPanel:onDestroy()
	for type, item in pairs(self._attrItems) do
		if item.tweenId then
			ZProj.TweenHelper.KillById(item.tweenId)

			item.tweenId = nil
		end
	end
end

function V3a6YaMiAttrPanel:onRefresh(mo, isShowHight, isAnim, isAudio)
	self.mo = mo

	local isPlayAudio = false
	local highValue = mo and mo:getHightestValue()

	for type, item in pairs(self._attrItems) do
		local info = V3a6YaMiEnum.AttrInfo[type]
		local value = mo and mo:getAttrValue(type) or 0

		item.isHight = isShowHight and highValue and value == highValue

		if item.tweenId then
			ZProj.TweenHelper.KillById(item.tweenId)
		end

		if not isPlayAudio then
			if value - (self._attrValue[type] or 0) > 0 then
				isPlayAudio = true
			end
		end

		if isAnim and self._attrValue[type] then
			item.tweenId = ZProj.TweenHelper.DOTweenFloat(self._attrValue[type], value, 0.3, self.tweenFrameCallback, self.tweenFinishCallback, self, item, EaseType.Linear)
		else
			if item.txtnum then
				item.txtnum.text = value
			end

			if item.txtname then
				item.txtname.text = luaLang(info.Name)
			end
		end

		if isPlayAudio and isAudio then
			AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_shuzi2)
		end

		self:_refreshHight(item)

		if item.imgicon then
			UISpriteSetMgr.instance:setV3a6YaMiSprite(item.imgicon, info.Icon)
		end

		self._attrValue[type] = value
	end
end

function V3a6YaMiAttrPanel:tweenFrameCallback(value, item)
	if item.txtnum then
		item.txtnum.text = math.ceil(value)
	end
end

function V3a6YaMiAttrPanel:tweenFinishCallback(item)
	self:_refreshHight(item)
end

function V3a6YaMiAttrPanel:_refreshHight(item)
	if not item then
		return
	end

	local isHight = item.isHight

	gohelper.setActive(item.gohighbg, isHight)

	if item.txtnum then
		if isHight then
			item.txtnum.color = self._hightColor or item.numColor
		end
	end

	if item.txtname then
		if isHight then
			item.txtname.color = self._hightColor or item.nameColor
		end
	end
end

return V3a6YaMiAttrPanel
