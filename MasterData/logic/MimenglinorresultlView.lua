-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglinorresultlView.lua

module("logic.extensions.mimengli.view.MimenglinorresultlView", package.seeall)

local MimenglinorresultlView = class("MimenglinorresultlView", ViewComponent)

function MimenglinorresultlView:unbindEvents()
	MimenglinorresultlView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnOk)
	GameUtil.rmClickHandler(self._btnCancel)
end

function MimenglinorresultlView:bindEvents()
	MimenglinorresultlView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOK, self)
end

function MimenglinorresultlView:buildUI()
	MimenglinorresultlView.super.buildUI(self)

	self._btnOk = self:getGo("btnOk")
	self._btnCancel = self:getGo("btnCancel")
	self._txtDesc = self:getTxt("txtDesc")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._empty = self:getGo("empty")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)
end

function MimenglinorresultlView:onExit()
	MimenglinorresultlView.super.onExit(self)
	self._scrollList:dispose()
end

function MimenglinorresultlView:onEnter()
	MimenglinorresultlView.super.onEnter(self)

	local pb = self:getFirstParam()

	if pb == nil then
		self:close()
	else
		self._activityId = pb.activityId
		self._confirmNum = pb.confirmNum
		self.fightPetHpInfo = pb.fightPetHpInfo

		if not pb.fightPetHpInfo then
			self._scrollList:reloadData(pb.fightPetHpInfo)
			GameUtil.SetActive(self._empty, false)

			if not pb.selectedTagBalanceResult then
				local arr = {}

				for i, v in ipairs(pb.selectedTagBalanceResult) do
					local tagType = v.left
					local cfg = MiMengLiConfig.instance:getBuffTagCfgById(self._activityId, tagType)

					if cfg and v.right > 0 then
						table.insert(arr, (langPara("%s:%s", cfg.name, v.right)))
					end
				end

				self._txtDesc.text = #arr > 0 and langPara("获得记忆碎片情况：\n%s", table.concat(arr, "\n")) or langPara("获得记忆碎片情况：\n%s", "\n<color=#eb4642>(无获得)</color>")
			end
		end
	end
end

function MimenglinorresultlView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	MaterialMgr.resetAll(con)

	local petMo = BagPetsController.instance:getPet(data.left)

	if petMo then
		local percent = 100

		if data.right == -1 then
			-- block empty
		else
			percent = Mathf.Clamp01(data.right / petMo._maxHp) * 100

			if percent > 0 and percent <= 1 then
				percent = 1
			end
		end

		if percent > 0 then
			if not ColorConst.Green2 then
				local colorStr = ColorConst.Red

				txtNum.text = string.format("<color=#%s>%d%%</color>", colorStr, percent)

				local proxy = MaterialMgr.setCellByMo(petMo, con)

				if proxy then
					proxy.binder:setClickCallBack(function(petCell)
						CommonTipsMgr.instance:openMaterialTips(con, MatType.Pet, petMo:getPetId())
					end)
				end
			end
		end
	end
end

function MimenglinorresultlView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function MimenglinorresultlView:_onClickOK()
	BattleController.instance:endBattle()
	MiMengLiController.instance:sendConfirm(self._activityId, self._confirmNum, true)
	self:close()
end

function MimenglinorresultlView:_onClickClose()
	BattleController.instance:endBattle()
	MiMengLiController.instance:sendConfirm(self._activityId, self._confirmNum, false)
	self:close()
end

return MimenglinorresultlView
