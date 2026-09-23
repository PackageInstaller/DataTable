function Refresh(_id, _name)
    if (_id == 17164) then
        LanguageMgr:SetText(txtDesc, _id, _name)
    else
        LanguageMgr:SetText(txtDesc, _id)
    end
end
