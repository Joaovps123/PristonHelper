# Priston Helper

**Priston Helper** é uma ferramenta leve e altamente otimizada criada em AutoHotkey para automatizar o uso de poções e o auto click no jogo **Priston Tale**. Permite configurar dinamicamente as posições e cores da barra de HP, MP e STM, garantindo máxima compatibilidade com diferentes resoluções de tela e interfaces personalizadas.

---

## ✨ Funcionalidades

- 🎯 **Auto Pot**: Usa coordenadas e cor exata para detectar quando usar poções automaticamente.
- 🖱️ **Auto Click**: Realiza cliques com o botão direito enquanto ativo.
- ⚙️ **Configuração dinâmica via atalho**: Configure facilmente as barras(HP, MP, STM) com atalhos personalizados.
- 💾 **Armazenamento de configurações**: Dados salvos no arquivo `PristonHelper.ini`, sem necessidade de reconfiguração a cada uso.
- 📌 **Tooltip informativo**: Exibe status em tempo real como "Potion", "AC", etc.
- 🔒 **Seguro e leve**: Nenhum processo desnecessário permanece ativo em segundo plano quando desativado.

---

## 🔧 Atalhos

| Atalho            | Ação                                |
| ----------------- | ----------------------------------- |
| Ctrl + Numpad 1   | Ativar o Priston Helper             |
| Ctrl + Numpad 2   | Ativar/desativar Auto Click         |
| Ctrl + Numpad 0   | Desativar completamente             |
| Ctrl + Numpad 7   | Configurar barra de HP              |
| Ctrl + Numpad 8   | Configurar barra de STM             |
| Ctrl + Numpad 9   | Configurar barra de MP              |
| Segurar tecla "A" | Pausar temporariamente o Auto Click |

---

## 🖼️ Como configurar as barras (HP / STM / MP)

1. **Certifique-se de que o sistema esteja desativado (Ctrl + Numpad 0)**.
2. Pressione o atalho de configuração desejado:
   - `Ctrl + Numpad 7`: HP
   - `Ctrl + Numpad 8`: STM
   - `Ctrl + Numpad 9`: MP
3. Um tooltip aparecerá com a posição atual do mouse e a cor.
4. **Clique com o botão esquerdo** para salvar a configuração.
5. **Clique com o botão direito** para cancelar.

---

## 📁 Estrutura do Arquivo INI

```ini
[HP]
X=412
Y=1370
Color=0xA40800

[STM]
X=385
Y=1426
Color=0x179C10

[MP]
X=596
Y=1425
Color=0x0121B6
```

---

## 💡 Requisitos

- Utilize a versão `.exe` para rodar diretamente sem dependências.
- Ou [AutoHotkey v1.1+](https://www.autohotkey.com/) instalado (caso deseje executar o script `.ahk`)

---

## 📌 Observações

- O script funciona apenas com a janela ativa do **Priston Tale**.
- Ao abrir pela primeira vez, o script cria automaticamente o arquivo `PristonHelper.ini` que deve ser configurado via atalhos.
- O Auto Click é pausado enquanto a tecla `A` estiver pressionada, para facilitar movimentações manuais e coleta de drops.

---

## 📜 Licença

Este projeto é distribuído gratuitamente para fins pessoais. Não é afiliado ou suportado oficialmente pelo jogo Priston Tale.
