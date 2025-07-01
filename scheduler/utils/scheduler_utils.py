# scheduler/utils/scheduler_utils.py (VERSÃO LIMPA)

def format_phone_number(phone: str) -> str:
    """
    Formata um número de telefone para o padrão 55DDDXXXXYYYY, removendo caracteres especiais.
    """
    # Remove qualquer coisa que não seja um dígito
    numeric_phone = ''.join(filter(str.isdigit, phone))

    # Se já tiver 55 no início e for um número válido, retorna
    if len(numeric_phone) == 13 and numeric_phone.startswith('55'):
        return numeric_phone

    # Se não tem o código do país, adiciona '55'
    if len(numeric_phone) in [10, 11]:
        return f"55{numeric_phone}"

    # Retorna o número como está se não se encaixar nas regras
    return numeric_phone

def format_group_id(group_id: str) -> str:
    """
    Garante que o ID do grupo tenha o sufixo '@g.us'.
    """
    if group_id and '@g.us' not in group_id:
        return f"{group_id}@g.us"
    return group_id