-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialSuperFmtRightCell.lua

module("logic.extensions.goddesstrial.view.GoddessTrialSuperFmtRightCell", package.seeall)

local GoddessTrialSuperFmtRightCell = class("GoddessTrialSuperFmtRightCell", CustomRightCell)

GoddessTrialSuperFmtRightCell.prefabUrl = "ui/views/goddesstrial/goddesstrialsuperfmtrightcell.prefab"

function GoddessTrialSuperFmtRightCell:ctor(target)
	self.mainGO = target.gameObject

	self:buildUI()
end

function GoddessTrialSuperFmtRightCell:buildUI()
	self._tag = goutil.findChild(self.mainGO, "goddessTag")
end

function GoddessTrialSuperFmtRightCell:setData(petMo)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

	GameUtil.SetActive(self._tag, skinCfg.genderId == 1)
end

return GoddessTrialSuperFmtRightCell
