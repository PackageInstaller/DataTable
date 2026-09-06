-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/view/OriginhuociyuanextView.lua

module("logic.extensions.originhuociyuan.view.OriginhuociyuanextView", package.seeall)

local OriginhuociyuanextView = class("OriginhuociyuanextView", ViewComponent)

function OriginhuociyuanextView:ctor()
	OriginhuociyuanextView.super.ctor(self)
end

function OriginhuociyuanextView:buildUI()
	OriginhuociyuanextView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
	self._effRootBuff = self:getGo("btnBuff/effRoot")
	self._petCon = self:getGo("btnBuff/petCon")
	self._iconBuff = self:getGo("btnBuff/icon")
	self._tagView = self:getGo("tagView")
end

function OriginhuociyuanextView:bindEvents()
	OriginhuociyuanextView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function OriginhuociyuanextView:unbindEvents()
	OriginhuociyuanextView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
end

function OriginhuociyuanextView:onEnter()
	OriginhuociyuanextView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1] or {}
	self._activityId = self._customFmtMo.activityId

	self.addGEvent(self, GlobalNotify.FormationChangeFinish, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.ORIGIN_HUOCIYUAN_BUFF_SELECT_CHANGE, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.ORIGIN_HUOCIYUAN_BUFF_SELECT_TIPS, self._divineMiZongClg_ForbitStartClg, self)
	self:_onUpdate()
end

function OriginhuociyuanextView:onExit()
	OriginhuociyuanextView.super.onExit(self)
end

function OriginhuociyuanextView:_divineMiZongClg_ForbitStartClg()
	self:playViewEffectUniGo("common/fx_ui_zhiyin_quan_03.prefab", self._effRootBuff, self._effRootBuff, false)
end

function OriginhuociyuanextView:_onUpdate()
	local fmo = self._customFmtMo:getCurFormation()

	for i = 1, 9 do
		local pId = checknumber(fmo:GetPosition(i))
		local buffId = self._customFmtMo:getPetBuff(pId)
		local cell = self:getGo("tagView/cell" .. i)

		GameUtil.SetActive(cell, buffId > 0)

		local txt = self:getTxt("tagView/cell" .. i .. "/txt")
		local typeTagImgChange = goutil.findChildComponent(cell, "typeImg", ComponentType.UIImageSpriteChange)

		if buffId > 0 then
			local buffCfg = OriginHuociyuanConfig.instance:getBuffCfgById(self._activityId, buffId) or {}

			txt.text = checknumber(buffCfg.buffNum)

			local tagTypeImageName = buffCfg.buffIcon

			if string.nilorempty(tagTypeImageName) then
				tagTypeImageName = "board_yq_xuanyun"
			end

			typeTagImgChange:ChangeSprite(tagTypeImageName)
		end
	end
end

function OriginhuociyuanextView:_onClickBuff()
	UIStateManager.instance:push(ViewName.OriginhuociyuanbuffView, self._customFmtMo)
end

return OriginhuociyuanextView
