-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandawakengiftView.lua

module("logic.extensions.newhandwelfare.view.NewhandawakengiftView", package.seeall)

local NewhandawakengiftView = class("NewhandawakengiftView", ViewComponent)

NewhandawakengiftView.DataConfig = {
	{
		raceId = 10027,
		funcId = 108,
		bgName = "bg_songshiguangfeilong",
		jumpTo = "ui#bonus#excellentclass"
	},
	{
		raceId = 10324,
		funcId = 186,
		bgName = "bg_songhuangjinshenglong",
		jumpTo = "ui#bonus#dragonfullawake"
	}
}

function NewhandawakengiftView:ctor()
	NewhandawakengiftView.super.ctor(self)
end

function NewhandawakengiftView:unbindEvents()
	NewhandawakengiftView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function NewhandawakengiftView:bindEvents()
	NewhandawakengiftView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnGo:AddClickListener(self._onClickbtnGo, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
end

function NewhandawakengiftView:buildUI()
	NewhandawakengiftView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnGo = self:getBtn("btnGo")
	self._btnInfo = self:getBtn("btnInfo")
	self._btnSkill = self:getBtn("btnSkill")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "imgPetName/txtName")
	self._bgGo = self:getGo("bg")
end

function NewhandawakengiftView:onExit()
	NewhandawakengiftView.super.onExit(self)
	uGuiUtil.clearImage(self._bgGo)
end

function NewhandawakengiftView:onEnter()
	NewhandawakengiftView.super.onEnter(self)

	local index = self:getFirstParam()

	self._showCfg = NewhandawakengiftView.DataConfig[index]
	self._raceId = self._showCfg.raceId

	self:_loadBg()
	self:_setName()
end

function NewhandawakengiftView:_onClickbtnClose()
	self:close()
end

function NewhandawakengiftView:_onClickbtnGo()
	if self._showCfg.funcId > 0 and not FuncOpenModel.instance:getFuncIsOpen(self._showCfg.funcId) then
		FloatWordMgr.instance:show(FuncOpenModel.instance:getFuncLockDescription(self._showCfg.funcId))

		return
	end

	if not string.nilorempty(self._showCfg.jumpTo) then
		GotoMgr.gotoByString(self._showCfg.jumpTo)
		self:close()
	end
end

function NewhandawakengiftView:_onClickbtnSkill()
	if self._raceId then
		PetCvController.instance:turnOffCurCv()
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function NewhandawakengiftView:_onClickbtnInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function NewhandawakengiftView:_loadBg()
	uGuiUtil.setSpriteToImage(self._bgGo, nil, GameUrl.getBigbgFolderUrl("newhand", self._showCfg.bgName))
end

function NewhandawakengiftView:_setName()
	local petCo = CharacterConfig.instance:getPetCo(self._raceId)

	self._txtName.text = petCo.name
end

return NewhandawakengiftView
