

function Refresh(_cardData)
	cardData = _cardData
	--bg
	SetBg(cardData:GetQuality())
	--icon
	SetIcon(cardData:GetSmallImg())
	--lv
	CSAPI.SetText(txtLv, cardData:GetLv() .. "")
end


function SetBg(_quality)
	local _quality = _quality or 1
	local bName = "btn_b_1_0" .. tostring(_quality)
	ResUtil.CardBorder:Load(bg, bName);
end


function SetIcon(iconName)
	if iconName then
		CSAPI.SetGOActive(icon, true);
		ResUtil.Card:Load(icon, iconName);
	else
		CSAPI.SetGOActive(icon, false);
	end
end 