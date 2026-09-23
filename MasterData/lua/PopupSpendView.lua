--消耗性通用面板
local id = nil
local num = 0
function Awake()
	LanguageMgr:SetText(txtDesc, 5004, StringUtil:SetByColor(1, "65ffb1"))
	--id = CoolMgr:GetCoolID()
end

--data {titleID,desc,itemID,surecb,cancelcb}
function OnOpen()
	--title
	LanguageMgr:SetText(txtTitle, data.titleID)
	--LanguageMgr:SetEnText(txtTitle2, data.titleID)
	--desc
	CSAPI.SetText(txtDesc, data.desc)
	--item
	local iconName = Cfgs.ItemInfo:GetByID(data.itemID).icon
	ResUtil.IconGoods:Load(icon, iconName, true)
	num = BagMgr:GetCount(data.itemID)
	CSAPI.SetText(txtCount, "" .. num)
end


function OnClickCancel()
	if(data.cancelcb) then
		data.cancelcb()
	end
	view:Close()
end

function OnClickOK()
	if(data.surecb) then
		data.surecb()
	end
	view:Close()
end