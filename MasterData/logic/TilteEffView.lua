-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/title/view/TilteEffView.lua

module("logic.extensions.title.view.TilteEffView", package.seeall)

local TilteEffView = class("TilteEffView")

function TilteEffView.Get(go, view)
	local effView = Framework.LuaComponentContainer.Add(go, TilteEffView)

	effView._view = view

	return effView
end

function TilteEffView:ctor(container)
	self._container = container
	self._effs = {}
end

function TilteEffView:setupTitle(id)
	id = checknumber(id)

	for k, v in pairs(self._effs) do
		v:setActive(k == id)
	end

	if id > 0 and self._effs[id] == nil then
		local cfg = TitleConfig.instance:getCfgById(id)

		if cfg then
			if not string.nilorempty(cfg.effResPath) then
				local resPath = string.format("fx_ui_chenghao/%s/%s.prefab", cfg.effResPath, cfg.effResPath)

				self._effs[id] = UIEffectManager.instance:playHUDEffect(resPath, self._container, true, nil, nil, function(target, eff)
					eff:setParent(self._container.transform)
					eff:setScale(1)
				end, nil)
			end
		else
			LoginController.instance:checkConfig(cfg)
		end
	end
end

function TilteEffView:clear()
	for _, v in pairs(self._effs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effs = {}
end

return TilteEffView
