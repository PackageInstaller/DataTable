

function Awake()
    
end

function Refresh(pageData,isShow)
    CSAPI.SetGOActive(gameObject,isShow)
    if pageData then
        if pageData:GetShowType()==ShopShowType.Atlas then
            CSAPI.SetText(txtNone,LanguageMgr:GetByID(18187))
        elseif pageData:GetShowType()==ShopShowType.Skin then
            CSAPI.SetText(txtNone,LanguageMgr:GetByID(18188))
        else
             CSAPI.SetText(txtNone,LanguageMgr:GetByID(18172))
        end
    else
        CSAPI.SetText(txtNone,LanguageMgr:GetByID(18172))
    end
end