-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/MaterialCell.lua

module("logic.extensions.material.proxy.MaterialCell", package.seeall)

local MaterialCell = class("MaterialCell")

function MaterialCell:ctor(target)
	self.target = target.gameObject
	self.autoTips = true
	self.view = nil
	self.type = nil
	self.id = nil
	self._isCellExit = true
end

function MaterialCell:getData()
	return self.data
end

function MaterialCell:getCfg()
	return self.cfg
end

function MaterialCell:setProxy(proxy)
	self.proxy = proxy
end

function MaterialCell:setData(data)
	self.data = data
end

function MaterialCell:setCfgData(cfg)
	self.cfg = cfg
end

function MaterialCell:setSelected(isSelected)
	self.selected = isSelected
end

function MaterialCell:setCallBack(cb)
	self.callback = cb
end

function MaterialCell:setNum(allNum, useNum)
	return
end

function MaterialCell:setNumStr(str)
	return
end

function MaterialCell:setLvl(num)
	return
end

function MaterialCell:setName(name)
	return
end

function MaterialCell:setEffStatus(flag)
	return
end

function MaterialCell:dispose()
	self.callback = nil
	self.data = nil
	self.view = nil

	self:setGray(false)
end

function MaterialCell:destroy()
	return
end

function MaterialCell:setAutoTips(boo)
	self.autoTips = boo
end

function MaterialCell:initCfg(matType, cfgId)
	self.type = matType
	self.id = cfgId
	self.autoTips = true

	local cfg = MaterialMgr.getMatCfg(matType, cfgId)

	if cfg == nil and Framework.OSDef.isEditor then
		printWarn(">>>>>MaterialCell initCfg 强制报错：配置错误 存在空的物品【" .. matType .. ":" .. cfgId .. "】")
	end

	self:setCfgData(cfg)
end

function MaterialCell:SetGray(boo)
	GameUtil.SetGray(self.target, boo)
end

function MaterialCell:setGray(boo)
	GameUtil.SetGray(self.target, boo)
end

function MaterialCell:setBgActive(isActive)
	return
end

function MaterialCell:SetView(view)
	self.view = view
end

function MaterialCell:playRareEffect(rare, parentGo)
	local url

	if rare == 5 then
		url = "fx_ui_kuang/fx_ui_kuang_chengse.prefab"
	elseif rare == 6 then
		url = "fx_ui_kuang/fx_ui_kuang_hongse.prefab"
	end

	return self:playCellEffect(url, parentGo)
end

function MaterialCell:playCellEffect(url, parentGo, loadEndDoneCallback)
	if url and parentGo then
		return (UIEffectManager.instance:playEffectBrief(nil, url, parentGo, true, function(finishHandlerTarget, eff)
			if not self._isCellExit or goutil.isNil(parentGo) then
				UIEffectManager.instance:stopEffect(eff)

				return
			end

			eff:setMultiScrollRect(false)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parentGo) + 1)
			eff:setParent(parentGo.transform)

			local trans = eff.effGo.transform

			Framework.TransformUtil.SetLocalPos(trans, 0, 0, 0)
			Framework.TransformUtil.SetLocalScale(trans, 1, 1, 1)

			local parentSVs = eff.effGo:GetComponentsInParent(typeof(UnityEngine.UI.ScrollRect), true)
			local parentSV

			if not goutil.isNil(parentSVs) and parentSVs.Length >= 2 then
				local parentScrollOfParent_0 = parentSVs[0]
				local parentScrollOfParent_1 = parentSVs[1]
				local transform_0 = parentScrollOfParent_0.gameObject.transform:GetChild(0)
				local transform_1 = parentScrollOfParent_1.gameObject.transform:GetChild(0)

				if transform_0 and transform_0.name == "doubleScrollViewport" then
					eff:setClipping(transform_0:GetComponent(goutil.Type_RectTransform))
				elseif transform_1 and transform_1.name == "doubleScrollViewport" then
					eff:setClipping(transform_1:GetComponent(goutil.Type_RectTransform))
				else
					eff:setMultiScrollRect(true)
				end
			else
				if not goutil.isNil(parentSVs) and parentSVs.Length > 0 then
					parentSV = parentSVs[0]
				end

				if parentSV then
					if not goutil.isNil(parentSV.viewport) then
						eff:setScrollRectClipping(parentSV)
					elseif not goutil.isNil(parentSV.content) then
						eff:setClipping(parentSV:GetComponent(goutil.Type_RectTransform))
					end
				else
					local rect = GlobalModel.instance.uiRoot.gameObject:GetComponent(goutil.Type_RectTransform)

					eff:setClipping(rect)
				end
			end

			local views = ViewMgr.instance._views

			for k, v in pairs(views) do
				if ViewMgr.instance:isOpen(k) and not goutil.isNil(v.mainGO) and eff.effGo.transform:IsChildOf(v.mainGO.transform) then
					eff.view = v._views[1]

					break
				end
			end

			if not eff.view then
				eff:setLayer(SceneLayer.Invisible_Value)
			else
				local isTop = GlobalModel.instance:isTopView(eff.view._viewPresentor)

				eff:setTop(isTop)
			end

			GameUtil.callBack(loadEndDoneCallback, finishHandlerTarget, eff)
		end))
	end
end

function MaterialCell:OnDestroy()
	self:dispose()

	self._isCellExit = false
end

function MaterialCell:getId()
	return self.id
end

function MaterialCell:setCustomIcon(path)
	return
end

return MaterialCell
