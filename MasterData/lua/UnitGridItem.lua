local canvasGroup = nil

function Awake()
	canvasGroup = ComUtil.GetCom(root, "CanvasGroup")
end

function Refresh(cfgID)
	local cardCfg = Cfgs.CardData:GetByID(cfgID)
	--bg
	LoadFrame(cardCfg.quality)
	--icon
	local modelCfg = Cfgs.character:GetByID(cardCfg.model)
	LoadIcon(modelCfg.icon)
	--name
	CSAPI.SetText(txtName, cardCfg.name)
	--get
	local data = RoleMgr:GetData(cfgID)
	CSAPI.SetGOActive(noGet, data == nil)
	canvasGroup.alpha = data == nil and 0.3 or 1
end

--加载框
function LoadFrame(lvQuality)
	if lvQuality then
		local frame = GridFrame[lvQuality];
		ResUtil.IconGoods:Load(bg, frame);
	else
		ResUtil.IconGoods:Load(bg, GridFrame[1]);
	end
end

--加载图标
function LoadIcon(iconName)
	CSAPI.SetGOActive(icon, iconName ~= nil);
	if(iconName) then
		ResUtil.RoleCard:Load(icon, iconName .. "")
	end
end
