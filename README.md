# Brief – Strengthen your pentest methodology. 

**Strengthen your CTF and pentest methodology by recording, analyzing, and learning from every command you run.**

Brief is a CLI tool that records your terminal activity during CTF challenges or labs, then uses AI to generate a detailed report. Instead of just getting the right answer, you get feedback on *how* you approached the problem—and how to improve next time.

---

##  What It Does

Brief helps you:

1. **Record** – Captures every command you run with timestamps and exit codes
2. **Organize** – Logs work across multiple terminal tabs with clear labels
3. **Analyze** – Sends your command history to an AI model for detailed feedback
4. **Learn** – Generates a mentor-style critique highlighting mistakes, bad habits, and better workflows
5. **Report** – Produces both Markdown and HTML reports you can review and share

---

##   Who This Is For

Brief is built for:

- **CTF learners** preparing for OSCP, CPTS, or other hands-on certifications
- **Pentesters** who want to refine their methodology under pressure
- **Self-taught security professionals** who need structured feedback without a course
- **Anyone** who wants to turn chaotic terminal activity into a clear, repeatable workflow

---

##   Why Brief Matters

After solving a CTF box, you ask: *"Was there a cleaner way? Did I just get lucky? What bad habits did I expose?"*

Walkthroughs show you *how others* solved it. Brief shows you *how you* approach problems—the gaps in your enumeration, where you chased noise, what you already knew but missed, and what habits slow you down under exam pressure.

### Example Value

Instead of just "you got the flag," Brief tells you:

> "You ran four different nmap scans without saving output and missed two open ports until the third run. You guessed at LFI payloads instead of discovering injectable parameters. You ran your reverse shell without testing it first, and you didn't inspect the sudo script before executing it. Here's what a disciplined workflow looks like..."

**That's how you build real methodology.**

---

## 📋 Quick Start

### 1. Install

```bash
git clone https://github.com/doany1/brief.git
cd brief
chmod +x requirements.sh
 ./requirements.sh
```

### If `requirements.sh` doesn't work:

```bash
python3 -m pip install --upgrade pip
python3 -m pip install openai
```
now rerun `./requirements.sh`

### 2. Get a Hugging Face API Token

1. Visit: https://huggingface.co/settings/tokens
2. Click "New token"
3. Select "Read" permissions
4. Click "Create Token"
5. Copy the token (starts with `hf_`)

### 3. Set Your Token

```bash
export HF_TOKEN=hf_xxxxxxxxxxxxxxxxx
```

## 🔧 Basic Commands

### Start a new session

```bash
brief --start
```


### Stop a session

```bash
brief --stop
```

### List your most recent session

```bash
brief --list
```

Outputs the full path of the latest session file.

### if you want to use existing session

```bash
brief --use <session name>
```

### Analyze a session (ingesting)

```bash
brief --ingest ~/.brief/sessions/htb-example-box.md
```

Sends the session to the AI model and generates reports.

### ingest the most recent session:

```bash
brief --latest
```

### View help

```bash
brief --help
```



## 📁 File Structure

All data is stored in `~/.brief/`:

```
~/.brief/
├── sessions/
│   ├── htb-example-box.md          # Your raw command log
│   ├── htb-another-box.md
│   └── ...
├── outputs/
│   ├── htb-example-box.analysis.md # AI analysis (Markdown)
│   ├── htb-example-box.analysis.html # AI analysis (HTML)
│   ├── htb-another-box.analysis.md
│   └── ...
├── .brief_bashrc                   # Internal shell config
├── .current_session                # Pointer to active session
└── autoattach.sh                   # Auto-attach hook (optional)
```

---

## 🚀 Workflow Example

### 1. Start your challenge

```bash
brief --start
# Enter name: htb-mysql-injection
# New shell opens, recording begins
```

### 2. Do your work (open a new tab or terminal it can save all history until you type `brief --stop`)
### for example From here you started sloving a box⬇️⬇️
```bash
# Recon
nmap -sS -sV -p- 10.10.10.20

# Enumeration
curl http://10.10.10.20
gobuster dir -u http://10.10.10.20 -w /usr/share/wordlists/dirb/common.txt

# Exploitation
curl http://10.10.10.20/?page=../../../../etc/passwd

# Reverse shell
nc -lvnp 4444
curl http://10.10.10.20/?cmd=bash+-i+...

# Post-exploitation
linpeas.sh
sudo -l
cat /root/root.txt
```
### and here you get root and you want to stop saving history ⬆️⬆️

# Then just Type when done
```bash
brief --stop
```

### 3. Get analysis

```bash
brief --latest
```
### OR 

```bash
brief -i <~/.brief/sessions/htb-mysql-injection.md> (When you end a session, it shows the location of the stored session file.use that session file,)
```
The tool:
- Queries the AI model (takes ~30-60 seconds)
- It Generates `htb-mysql-injection.analysis.md` (Markdown) (you can open in any text editor)
- It Generates `htb-mysql-injection.analysis.html` (styled HTML) (you can open this using firefox or chrome)

### 4. Read the report

```bash
# Plain text
cat ~/.brief/outputs/htb-mysql-injection.analysis.md

# Or open in browser
firefox ~/.brief/outputs/htb-mysql-injection.analysis.html
```

---

## 📊 What the Analysis Includes

Brief's AI mentor will:

1. **Identify mistakes** – Scans repeated without output saved, blind payload guessing, unverified assumptions
2. **Highlight patterns** – "You always run nmap four times" or "You skip the LFI enumeration step"
3. **Explain reasoning** – Why a technique was weak and what it reveals about your approach
4. **Suggest better commands** – Exact replacements with proper flags, encoding, and output redirection
5. **Provide a refined workflow** – A complete, copy-paste-ready methodology for the next box
6. **Test strategy** – How to validate payloads before committing (always test with `id` first)

Example snippet from a report:

> **Nmap Scans:** You ran four different nmap commands without saving output and re-scanned the same ports multiple times. Better: one quick sweep (`nmap -sS -p- --min-rate 2000`), then a single detailed scan (`nmap -sS -sV -sC -p <open-ports>`), then targeted vuln scripts. Always use `-oA <basename>` to save results.

---

## 🔒 Privacy & Security

- **Local storage**: All session files are stored on your machine in `~/.brief/`
- **Selective transmission**: Data is sent to Hugging Face *only* when you run `--ingest` or `--latest` to create report on your history.  
- **API token**: Used only to authenticate with Hugging Face; never stored locally
---

## 🛠 Troubleshooting

### Commands not recording?

1. Make sure you started with `brief --start` (not `--use`)
2. Verify you're in the shell that was opened by Brief

### Commands are recording but analysis is empty or slow?

1. Ensure you have internet access
2. Check that `HF_TOKEN` is set: `echo $HF_TOKEN`
3. Verify the token is valid (visit https://huggingface.co/settings/tokens)
4. If the session is very large (1000+ commands), it may take longer

### "No sessions found"

- Run `brief --start` to create a new session first
- Check that `~/.brief/sessions/` directory exists and contains `.md` files

### API token errors?

1. Double-check the token format: `hf_xxxxxxxxxxxxxxxx...`
2. Regenerate a new token if needed
3. Make sure it's set before running `brief --latest`: `echo $HF_TOKEN | head -c 10`

---

## 📖 How AI Analysis Works

Brief uses the Hugging Face API with an open-source LLM (currently `openai/gpt-oss-120b:groq`). When you run `--ingest`:

1. Your session log is read from `~/.brief/sessions/`
2. The log is sent to the AI model with a prompt asking for a mentor-style critique
3. The model analyzes your command sequence, identifies mistakes, and suggests improvements
4. The response is saved as Markdown (`.analysis.md`) and converted to HTML (`.analysis.html`)
5. No session data is stored on Hugging Face; it's processed and discarded

The AI prompt includes:

> "Roast my command history like a strict but helpful mentor. Point out every mistake, explain why it was wrong, and show me the correct methodology with better commands and workflows."



**Happy hacking. Build better methodology.**
