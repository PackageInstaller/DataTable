---@class MailTable
---@field public id integer
---@field public MailTitle LocalStrEnum
---@field public MailSender LocalStrEnum
---@field public MailContent LocalStrEnum

---@type MailTable[]
local MailTable = {
                [10001] = {
                        id = 10001,
                        MailTitle = LocalStrEnum.PassportMailTitle,
                        MailSender = LocalStrEnum.PassportMailSender,
                        MailContent = LocalStrEnum.PassportMailContent ,
                },

}
return MailTable