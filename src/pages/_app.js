import "@/styles/globals.css";
import Navbar from "components/Navbar/Navbar";
import { VotingProvider } from "context/Voter";

export default function App({ Component, pageProps }) {
  return (
    <VotingProvider>
      <div>
        <Navbar />
        <div>
          <Component {...pageProps} />
        </div>
      </div>
    </VotingProvider>
  );
}
