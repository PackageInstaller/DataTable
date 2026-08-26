-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErResultTargetItem.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErResultTargetItem", package.seeall)

local MoLiDeErResultTargetItem = class("MoLiDeErResultTargetItem", LuaCompBase)

function MoLiDeErResultTargetItem:init(go)
	self.viewGO = go
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "#txt_taskdesc")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "result/#go_finish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErResultTargetItem:_editableInitView()
	return
end

function MoLiDeErResultTargetItem:refreshUI(desc, param, isComplete, isMain)
	local data = string.splitToNumber(param, "#")
	local type = data[1]

	if type == MoLiDeErEnum.TargetType.RoundFinishAll or type == MoLiDeErEnum.TargetType.RoundFinishAny then
		local realRound = MoLiDeErHelper.getRealRound(data[2], isMain)

		desc = GameUtil.getSubPlaceholderLuaLang(desc, {
			realRound
		})
	end

	if isComplete then
		if not MoLiDeErEnum.ResultTargetColor.Success then
			local color = MoLiDeErEnum.ResultTargetColor.Fail

			desc = string.format("<color=%s>%s</color>", color, desc)
			self._txttaskdesc.text = desc

			if isMain then
				if not MoLiDeErEnum.TargetId.Main then
					local targetId = MoLiDeErEnum.TargetId.Extra

					if isComplete then
						if not MoLiDeErEnum.ProgressChangeType.Success then
							local progressState = MoLiDeErEnum.ProgressChangeType.Percentage

							UISpriteSetMgr.instance:setMoLiDeErSprite(self._imageIcon, string.format("v2a8_molideer_game_targeticon_0%s_%s", targetId, progressState))
						end
					end
				end
			end
		end
	end
end

function MoLiDeErResultTargetItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function MoLiDeErResultTargetItem:onDestroy()
	return
end

return MoLiDeErResultTargetItem
